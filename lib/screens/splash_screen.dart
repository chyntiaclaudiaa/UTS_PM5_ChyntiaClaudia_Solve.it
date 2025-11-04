import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/NameApp.png',
                height: 50,
              ),
              const SizedBox(height: 16),

              // 2. Tagline
              const Text(
                'Interesting QUIZ Awaits You',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),

              Image.asset(
                'assets/images/logo_solveit.png',
                height: 250,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
