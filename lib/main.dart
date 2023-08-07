import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/layouts/shopping_layout.dart';
import 'package:ecommerce_app/modules/admin/add_product_screen.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/modules/products/products_view_screen.dart';
import 'package:ecommerce_app/modules/register/register_screen.dart';
import 'package:ecommerce_app/modules/splash/splash_screen.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce app',
      debugShowCheckedModeBanner: false,
      home: ProductsViewScreen(categoryType: CategoryType.allProducts),
    );
  }
}