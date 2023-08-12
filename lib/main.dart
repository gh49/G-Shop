import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/modules/splash/splash_screen.dart';
import 'package:ecommerce_app/shared/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce app',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}