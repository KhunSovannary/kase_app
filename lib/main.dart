import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kase_app/screen/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
