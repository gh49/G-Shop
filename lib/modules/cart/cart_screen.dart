import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  CartScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: pageStorageKey,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
            Text("Cart Screen", style: TextStyle(fontSize: 50.0),),
          ],
        ),
      ),
    );
  }
}
