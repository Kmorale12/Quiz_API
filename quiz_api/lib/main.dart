import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue), // Set the primary color
      home: SetupScreen(), // Start with the SetupScreen
    );
  }
}
