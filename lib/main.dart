import 'package:flutter/material.dart';

import 'screens/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Sqflite login"),
        ),
        body: Home(),
      ),
    );
  }
}
