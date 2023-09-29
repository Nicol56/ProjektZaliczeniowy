import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Image.asset(
          'images/home_screen.jpg',
          width: 200, //
          height: 200, //
        ),
      ),
    );
  }
}