import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import '../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    return MainBackground(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/NameApp.png',
                    height: 45,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 60),
                  const Text(
                    'What should we call you?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name Here...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    text: "Let's Get Started",
                    onPressed: () {
                      String userName = nameController.text.trim();
                      if (userName.isEmpty) {
                        // Ganti nama kosong jadi "Guest"
                        userName = "Guest";
                      }

                      context.goNamed(
                        'home',
                        pathParameters: {'userName': userName},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}