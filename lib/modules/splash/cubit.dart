import 'dart:io';

import 'package:ecommerce_app/modules/splash/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());
  static SplashCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  Future<void> init() async {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    await Future.delayed(const Duration(seconds: 1));

    if(FirebaseAuth.instance.currentUser == null) {
      emit(SplashNotLoggedInState());
      return;
    }

    FirebaseAuth.instance.signOut();

    FirebaseAuth.instance.currentUser!.getIdToken().then((value) {
      emit(SplashLoggedInState());
    }).catchError((error) {
      FirebaseAuth.instance.signOut();
      emit(SplashNotLoggedInState());
    });

  }

  void simulateServiceCall(int seconds) {
    Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
    });
  }
}