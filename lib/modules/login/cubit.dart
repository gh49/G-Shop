import 'package:ecommerce_app/modules/login/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}