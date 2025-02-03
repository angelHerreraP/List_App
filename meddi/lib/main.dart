import 'package:flutter/material.dart';
import 'package:meddi/presentation/Pages/Splashscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splashscreen(), // Inicia en SplashScreen
    );
  }
} 
