import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_data.dart';
import 'package:ecommerce_app/modules/edit_profile/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitialState());
  static EditProfileCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init() {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    getUserData();
  }

  String? gender;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  void toggleGender(String value) {
    gender = value;
    emit(EditProfileToggleGenderState());
  }

  UserData? user;

  void getUserData() {
    var firestore = FirebaseFirestore.instance;
    var userDocument = firestore.collection("users");
    userDocument.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      user = UserData.fromJson(value.data());
      print(user);
      gender = user?.gender;
      nameController.text = user?.name ?? "";
      phoneController.text = user?.phoneNumber ?? "";
      dobController.text = user?.dateOfBirth ?? "";
      emit(EditProfileGetDataSuccessState());
    }).catchError((error) {
      emit(EditProfileGetDataErrorState());
      print(error.toString());
    });
  }

  void emitInvalidInput() {
    emit(EditProfileInvalidInputState());
  }

  void updateUserData() {
    emit(EditProfileUpdateDataLoadingState());
    Map<String, dynamic>? newData = {};

    if(nameController.text != (user?.name ?? "")) {
      newData["name"] = nameController.text;
    }
    if(gender != (user?.gender ?? "")) {
      newData["gender"] = gender;
    }
    if(phoneController.text != (user?.phoneNumber ?? "")) {
      newData["phoneNumber"] = phoneController.text;
    }
    if(dobController.text != (user?.dateOfBirth ?? "")) {
      newData["dateOfBirth"] = dobController.text;
    }

    String uID = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance;
    var usersCollection = firestore.collection("users");

    usersCollection.doc(uID).update(newData).then((value) {
      emit(EditProfileUpdateDataSuccessState());
    }).catchError((error) {
      emit(EditProfileUpdateDataErrorState());
    });
  }
}