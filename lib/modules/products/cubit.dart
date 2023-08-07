import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/products/states.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsViewCubit extends Cubit<ProductsViewStates> {
  ProductsViewCubit() : super(ProductsViewInitialState());
  static ProductsViewCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;

  void init(CategoryType categoryType) {
    if(!isInitState) {
      return;
    }
    else {
      isInitState = false;
    }

    simulateServiceCall(1);

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "admin@admin.com",
        password: "admin49")
        .then((value) {
      simpleQuery(categoryType);
    })
        .catchError((error) {
      print("Something went wrong");
    });
  }

  void emitInvalidInput() {
    emit(ProductsViewInvalidInputState());
  }

  List<ProductData> queryResult = [];

  void simpleQuery(CategoryType categoryType) {
    var db = FirebaseFirestore.instance;
    var productsRef = db.collection('products');
    var query = productsRef.where("category", isEqualTo: ProductData.getCategoryText(categoryType));

    if(categoryType == CategoryType.allProducts) {
      query = productsRef.where("quantity", isGreaterThan: 0);
    }

    query.get().then((products) {
      for (var product in products.docs) {
        print(product.data());
        ProductData productData = ProductData.fromJson(product.data());
        queryResult.add(productData);
      }
      emit(ProductsViewSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  ProductData getDataWithCasting(Map<String, dynamic> json) {
    return ProductData(
      name: json['name'],
      pID: json['pID'],
      rating: double.parse(json['rating']),
      ratingCount: json['ratingCount'],
      image: json['image'],
      quantity: json['quantity'],
      category: json['category'],
      description: json['description'],
      price: double.parse(json['price']),
    );
  }

  void simulateServiceCall(int seconds) {
    Future.delayed(Duration(seconds: seconds)).
    then((value) {
      print("Service Call Completed");
      emit(ProductsViewInitialState());
    });
  }
}