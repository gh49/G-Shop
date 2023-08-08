import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product_data.dart';
import 'package:ecommerce_app/modules/products/states.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:ecommerce_app/shared/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsViewCubit extends Cubit<ProductsViewStates> {
  ProductsViewCubit() : super(ProductsViewInitialState());
  static ProductsViewCubit get(context) => BlocProvider.of(context);

  bool isInitState = true;
  bool fetchingData = true;

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
  List<ProductData> productsList = [];

  void simpleQuery(CategoryType categoryType) {
    var db = FirebaseFirestore.instance;
    var productsRef = db.collection('products');
    var query = productsRef.where("category", isEqualTo: ProductData.getCategoryText(categoryType));

    if(categoryType == CategoryType.allProducts) {
      query = productsRef.where("quantity", isGreaterThan: 0);
    }

    query.get().then((products) {
      for (var product in products.docs) {
        ProductData productData = ProductData.fromJson(product.data());
        productsList.add(productData);
      }
      queryResult = cloneList(productsList);
      sortProducts(queryResult, CompareBy.name);
      fetchingData = false;
      emit(ProductsViewSuccessState());
    }).catchError((error) {
      fetchingData = false;
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

  void search(String keyword, CompareBy compareBy, RangeValues priceRange, RangeValues ratingRange) {
    List<ProductData> result = [];
    for(int i=0; i<productsList.length; i++) {
      if(productsList[i].name != null && productsList[i].name!.toLowerCase().contains(keyword.toLowerCase())) {
        result.add(productsList[i]);
      }
    }
    //Apply Filters on result
    queryResult = result;
    sortProducts(queryResult, compareBy);
    applyFilters(priceRange, ratingRange);
    emit(ProductsViewUpdateProductsListState());
  }

  List<T> cloneList<T>(List<T> list) {
    List<T> clonedList = [];

    for(int i=0; i<list.length; i++) {
      clonedList.add(list[i]);
    }
    return clonedList;
  }

  void sortProductsView(CompareBy compareBy) {
    print("${queryResult[0].name} and ${queryResult[1].name}");
    print("${queryResult[0].compareTo(queryResult[1], CompareBy.name)}");
    print("${queryResult[0].compareTo(queryResult[1], CompareBy.nameD)}");
    sortProducts(queryResult, compareBy);
    emit(ProductsViewUpdateProductsListState());
  }

  void applyFilters(RangeValues priceRange, RangeValues ratingRange) {
    List<ProductData> result = [];

    for(var product in queryResult) {
      double price = product.price??0.0;
      double rating = product.rating??0.0;
      if(price >= priceRange.start && price <= priceRange.end
      && rating >= ratingRange.start && rating <= ratingRange.end) {
        result.add(product);
      }
    }

    queryResult = result;
  }

}