import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/product_details/states.dart';
import 'package:ecommerce_app/modules/products/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:ecommerce_app/shared/dio_helper.dart';
import 'package:ecommerce_app/shared/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());
  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;
  bool fetchingData = true;

  void init(String pID) {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    getProductData(pID);
  }

  ProductData? product;

  void getProductData(String pID) {
    FirebaseFirestore.instance.collection("products").doc(pID).get().then((value) {
      product = ProductData.fromJson(value.data()!);
      emit(ProductDetailsGetDataSuccessState());
    }).catchError((error) {
      emit(ProductDetailsGetDataErrorState());
    });
  }

  void addToCart(BuildContext context, String pID) {
    //Check if there is sufficient quantity
    emit(ProductDetailsAddToCartLoadingState());

    DioHelper.addToCart(pID).then((value) {
      emit(ProductDetailsAddToCartSuccessState());
      showToast(context, "Product Added to Cart Successfully", ToastType.success);
    }).catchError((error) {
      emit(ProductDetailsAddToCartErrorState());
      showToast(context, "Failed to Add Product to Cart", ToastType.error);
    });
  }
}