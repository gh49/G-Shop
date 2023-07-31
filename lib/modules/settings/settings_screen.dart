import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  PageStorageKey<String> pageStorageKey;
  SettingsScreen({super.key, required this.pageStorageKey});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: pageStorageKey,
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
            Text("Settings Screen", style: TextStyle(fontSize: 50.0),),
          ],
        ),
      ),
    );
  }
}
