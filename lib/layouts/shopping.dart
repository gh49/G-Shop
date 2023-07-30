import 'package:ecommerce_app/shared/constants.dart';
import 'package:flutter/material.dart';

class ShoppingLayout extends StatelessWidget {
  const ShoppingLayout({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
