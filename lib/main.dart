import 'package:flutter/material.dart';
import 'package:kasir/landing.dart';
import 'landing.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //judul
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: Landing(),
    );
  }
}