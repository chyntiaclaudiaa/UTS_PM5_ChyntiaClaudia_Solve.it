import 'package:flutter/material.dart';
import 'package:uts_pm5_slove_it/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solve.it',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),

      home: const SplashScreen(),
    );
  }
}