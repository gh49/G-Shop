import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/modules/splash/cubit.dart';
import 'package:ecommerce_app/modules/splash/states.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashCubit(),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {
          if(state is SplashLoggedInState) {
            navigateAndFinish(context, LoginScreen());
          }
        },
        builder: (context, state) {
          var cubit = SplashCubit.get(context);
          cubit.init();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 110.0,
                    child: Image(
                      image: AssetImage("assets/shopping_cart.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "G Shop",
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: "QuickSand",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
