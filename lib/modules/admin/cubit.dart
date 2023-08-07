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

    simulateServiceCall(2);
    
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
    FirebaseFirestore.instance.collection("products").
    add(productData.toJson()).
    then((value) {
      productData.pID = value.id;
      value.update(productData.toJson()).
      then((value) {
        emit(AddProductSuccessState());
      }).
      catchError((error) {
        emit(AddProductErrorState(error.toString()));
      });
    }).
    catchError((error) {
      emit(AddProductErrorState(error.toString()));
    });
  }

  void emitInvalidInput() {
    emit(AddProductInvalidInputState());
  }

  void simpleQuery() {
    var db = FirebaseFirestore.instance;
    var productsRef = db.collection('products');
    var query = productsRef.where("quantity", isGreaterThan: 0);
    query.get().then((value) {
      print("Checking");
      for (var docSnapshot in value.docs) {
        if(docSnapshot.data()['name'].toString().contains("Pantene")) {
          print(docSnapshot.data());
        }
      }
    }).catchError((error) {
      print("Error");
    });
  }
  
  void simulateServiceCall(int seconds) {
    Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
      emit(AddProductInitialState());
    });
  }
}