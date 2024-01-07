import 'package:flutter/material.dart';
import 'package:simple_calculator_app/screen_view.dart';

void main() =>  runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true
      ),
      home: const Calculator()
    );
  }
}


