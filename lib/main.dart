import 'package:flutter/material.dart';
import 'package:musicomapp/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musicom App',
      home: WelcomeScreen(),
    );
  }
}

