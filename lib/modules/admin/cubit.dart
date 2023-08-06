import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/models/user_data.dart';
import 'package:ecommerce_app/modules/admin/states.dart';
import 'package:ecommerce_app/modules/register/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());
  static AddProductCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init() {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }
    
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "admin@admin.com",
        password: "admin49")
        .then((value) {
          print("Admin logged in");
        })
        .catchError((error) {
          print("Something went wrong");
        });
  }

  void addProduct(ProductData productData) {
    print(productData.toString());
  }

  void emitInvalidInput() {
    emit(AddProductInvalidInputState());
  }
  
  void simulateServiceCall(int seconds) {
    Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
      emit(AddProductSuccessState());
    });
  }
}