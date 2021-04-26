
import 'package:app_calculator/home_screen.dart';
import 'package:flutter/material.dart';

void main()=>runApp(CalculatorApp());


class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "App Calculator",
      home:HomeScreen() ,
    );
  }
}