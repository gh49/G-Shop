import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/user_data.dart';
import 'package:ecommerce_app/modules/register/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init() {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

  }

  String gender = "male";

  void toggleGender(String value) {
    gender = value;
    emit(RegisterToggleGenderState());
  }

  void emitInvalidInput() {
    emit(RegisterInvalidInputState());
  }

  void register(
      String name,
      String gender,
      String email,
      String phoneNumber,
      String password,
      String dateOfBirth,
      ) {

    emit(RegisterLoadingState());
    UserData newUser = UserData(
        name: name,
        gender: gender,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        uID: "",
    );

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).
    then((value) {
      newUser.uID = value.user!.uid;
      FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set(newUser.toJson()).
      then((value) {
        emit(RegisterSuccessState());
      }).
      catchError((error) {
        emit(RegisterErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void simulateServiceCall(int seconds) {
    Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
      emit(RegisterSuccessState());
    });
  }
}