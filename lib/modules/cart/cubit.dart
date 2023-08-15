import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/cart/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init() {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    getCart();
  }

  List<Map<String, dynamic>?> cart = [];

  Future<void> getCart() async {
    cart = [];
    String uID = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("carts").doc(uID).collection("products").get().
    then((items) async {
      for(var item in items.docs) {
        print(item.id);
        await addToCartList(item.id, item.data()["pID"]);
      }
      try {
        emit(CartGetDataSuccessState());
      }
      catch(e) {
        print(e.toString());
      }
    });
  }

  Future<void> addToCartList(String cID, String pID) async {
      await FirebaseFirestore.instance.collection("products").doc(pID).get().then((value) {
        Map<String, dynamic>? data = value.data();
        data?["cID"] = cID;

      cart.add(data);
    }).catchError((error) {
      try {
        emit(CartGetDataErrorState());
      }
      catch(e) {
        print(e.toString());
      }
    });
  }

  double getTotal() {
    double sum = 0;
    for(var product in cart) {
      double price = product?["price"] ?? 0;
      sum += price;
    }
    return sum;
  }

  void removeFromCart(String cID) {
    String uID = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection("carts").doc(uID).collection("products").
    doc(cID).delete().then((value) {
      Map<String, dynamic>? deletedItem = getCartItemByCID(cID);
      cart.remove(deletedItem);
      emit(CartRemoveProductSuccessState());
    }).catchError((error) {
      try {
        emit(CartRemoveProductErrorState());
      }
      catch(e) {
        print(e.toString());
      }
    });
  }

  Map<String, dynamic>? getCartItemByCID(String cID) {
    for(var item in cart) {
      if(item?["cID"] == cID) {
        return item;
      }
    }
    return null;
  }

  Future<void> checkOut() async {
    emit(CartCheckoutLoadingState());
    if(cart.isEmpty) {
      emit(CartCheckoutErrorState());
      return;
    }

    double total = getTotal();
    //FIRST CHECK IF THERE IS QUANTITY "SPECIAL CASE WITH DUPLICATES"
    //THEN REMOVE THE CORRECT QUANTITY FROM THE PRODUCT
    List<String> pIDList = [];
    for(var product in cart) {
      await FirebaseFirestore.instance.collection("carts").
      doc(FirebaseAuth.instance.currentUser!.uid).
      collection("products").doc(product?["cID"]).delete().catchError((error) {
        print(error.toString());
        try {
          emit(CartCheckoutErrorState());
        }
        catch(e) {
          print(e.toString());
        }
      });

      pIDList.add(product?["pID"]);
    }
    DateTime now = DateTime.now();
    String dateTimeString = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
    await FirebaseFirestore.instance.collection("orders").
    add({
      "uID": FirebaseAuth.instance.currentUser!.uid,
      "products": pIDList,
      "dateTime": dateTimeString,
      "total": total,
    });

    cart = [];
    print("DONE");

    try {
      emit(CartCheckoutSuccessState());
    }
    catch(e) {
      print(e.toString());
    }
  }
}