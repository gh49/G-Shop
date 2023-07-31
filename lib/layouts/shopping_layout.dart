import 'package:ecommerce_app/layouts/cubit.dart';
import 'package:ecommerce_app/layouts/states.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingLayout extends StatelessWidget {
  const ShoppingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCubit(),
      child: BlocConsumer<ShoppingCubit, ShoppingStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              actions: [
                IconButton(
                    onPressed: (){
                      FirebaseAuth.instance.signOut().then((value) {
                        navigateAndFinish(context, LoginScreen());
                      }).catchError((error) {
                        navigateAndFinish(context, LoginScreen());
                      });
                    },
                    icon: const Icon(Icons.logout),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: myOrange,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
              ],
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
                    "Main Application",
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
