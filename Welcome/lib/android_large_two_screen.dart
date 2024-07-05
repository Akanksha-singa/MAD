import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AndroidLargeTwoScreen(),
    );
  }
}

class AndroidLargeTwoScreen extends StatelessWidget {
  const AndroidLargeTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Center(
          child: Container(
            height: 102,
            width: 264,
            alignment: Alignment.center,
            child: Text(
              "WELCOME",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFFFF4D4D),
                fontSize: 39.40707015991211,
                fontFamily: 'Inknut Antiqua',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}