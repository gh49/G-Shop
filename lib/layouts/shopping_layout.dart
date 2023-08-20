import 'package:ecommerce_app/layouts/cubit.dart';
import 'package:ecommerce_app/layouts/states.dart';
import 'package:ecommerce_app/modules/home/home_screen.dart';
import 'package:ecommerce_app/modules/login/login_screen.dart';
import 'package:ecommerce_app/shared/components.dart';
import 'package:ecommerce_app/shared/constants.dart';
import 'package:ecommerce_app/shared/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingLayout extends StatelessWidget {
  ShoppingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingCubit(),
      child: BlocConsumer<ShoppingCubit, ShoppingStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = ShoppingCubit.get(context);
          cubit.init();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: myOrange,
              elevation: 0.0,
              title: Text(
                cubit.titles[cubit.screenIndex],
                style: TextStyle(
                  fontFamily: "QuickSand"
                ),
              ),
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
                IconButton(
                  onPressed: (){
                    cubit.getTokenTest();

                  },
                  icon: const Icon(Icons.question_mark),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: myOrange,
              currentIndex: cubit.screenIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
              ],
              onTap: (int index) {
                cubit.changeBottomNavigation(index);
              },
            ),
            body: cubit.screens[cubit.screenIndex],
          );
        },
      ),
    );
  }
}
