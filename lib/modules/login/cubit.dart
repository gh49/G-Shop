import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modules/login/states.dart';
import 'package:ecommerce_app/shared/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  Future<void> init() async {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    await simulateServiceCall(1);
    emit(LoginInitialState());
  }

  Future<void> simulateServiceCall(int seconds) async {
    await Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
    });
  }

  bool showPassword = false;
  Icon passwordSuffixIcon = const Icon(Icons.visibility);

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    if(showPassword) {
      passwordSuffixIcon = const Icon(Icons.visibility_off);
    }
    else {
      passwordSuffixIcon = const Icon(Icons.visibility);
    }
    emit(LoginTogglePasswordVisibility());
  }

  void emailLogin(String email, String password) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    then((value) {
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).
    then((value) {
      emit(LoginSuccessState());
      return value;
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  //Method for testing tokens in API
  Future<String> getTokenTest() async {
    String idToken = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    FirebaseFirestore.instance.collection("tokens").doc("testtoken").set({"token": idToken}).
    then((value) {

    }).catchError((onError) {

    });

    DioHelper.getProducts("allProducts").then((value) {
      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
    });
    return idToken;
  }


}