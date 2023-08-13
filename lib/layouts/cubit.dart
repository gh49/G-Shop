import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/layouts/states.dart';
import 'package:ecommerce_app/models/screen_switcher.dart';
import 'package:ecommerce_app/modules/cart/cart_screen.dart';
import 'package:ecommerce_app/modules/home/home_screen.dart';
import 'package:ecommerce_app/modules/settings/settings_screen.dart';
import 'package:ecommerce_app/shared/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCubit extends Cubit<ShoppingStates> {
  ShoppingCubit() : super(ShoppingInitialState());
  static ShoppingCubit get(context) => BlocProvider.of(context);

  bool isInit = true;

  List<PageStorageKey<String>> pageKeys = [
    PageStorageKey<String>("homeKey"),
    PageStorageKey<String>("cartKey"),
    PageStorageKey<String>("settingsKey"),
  ];

  List<Widget> screens = [];

  void init() {
    if(!isInit) {
      return;
    }
    isInit = false;

    screens = [
      HomeScreen(pageStorageKey: pageKeys[0]),
      CartScreen(pageStorageKey: pageKeys[1]),
      SettingsScreen(pageStorageKey: pageKeys[2]),
    ];
  }

  List<String> titles = [
    "Home",
    "Cart",
    "Settings",
  ];

  int screenIndex = 0;

  void changeBottomNavigation(int index) {
    screenIndex = index;
    emit(ShoppingBotNavIndexChangedState());

  }
  //
  // ScreenSwitcher screenSwitcher = ScreenSwitcher([
  //   ScreenData(widget: HomeScreen(), icon: Icon(Icons.home), name: "Home"),
  //   ScreenData(widget: CartScreen(), icon: Icon(Icons.shopping_cart), name: "Cart"),
  //   ScreenData(widget: SettingsScreen(), icon: Icon(Icons.settings), name: "Settings"),
  // ]);
  //
  // void changeScreen(int index) {
  //   if(index == screenSwitcher.currentIndex) {
  //     return;
  //   }
  //   screenSwitcher.setIndex(index);
  //   emit(ShoppingBotNavIndexChangedState());
  // }

  void testEmit() {
    emit(ShoppingTestState());
  }

  Future<String> getTokenTest() async {
    String idToken = await FirebaseAuth.instance.currentUser?.getIdToken() ?? "";
    FirebaseFirestore.instance.collection("tokens").doc("testtoken").set({"token": idToken}).
    then((value) {

    }).catchError((onError) {

    });

    DioHelper.getProducts({"category": "electronics"}).then((value) {
      print((value.data as List<dynamic>).length);
    }).catchError((error) {
      print(error.toString());
    });
    return idToken;
  }
}