import 'package:flutter/material.dart';
import 'package:uts_pm5_slove_it/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solve.it',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug

      theme: ThemeData(
        // 1. Font default untuk seluruh aplikasi (Kriteria 5)
        fontFamily: 'Poppins',

        // 2. Latar belakang Scaffold dibuat transparan
        //    agar gradient dari MainBackground bisa terlihat.
        scaffoldBackgroundColor: Colors.transparent,

        // 3. Mengatur tema dasar ke gelap
        brightness: Brightness.dark,
      ),

      // 4. Memulai aplikasi dari WelcomeScreen (Halaman 1)
      home: const WelcomeScreen(),
    );
  }
}