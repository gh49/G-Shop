import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  HomeScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: pageStorageKey,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
            Text("Home Screen", style: TextStyle(fontSize: 50.0),),
          ],
        ),
      ),
    );
  }
}
