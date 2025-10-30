import 'package:flutter/material.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/mode_button.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  static const Color kGreenLight = Color(0xFF9DFF4F);
  static const Color kGreenDark = Color(0xFF1ABD00);

  static const Color kOrangeLight = Color(0xFFFFD540);
  static const Color kOrangeDark = Color(0xFFFFA800);


  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/NameApp.png',
                  height: 45,
                ),
                const SizedBox(height: 16),
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
                  height: 200,
                ),
                const SizedBox(height: 50),

                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Hi, $userName! 👋\nDiscover your game style: Challenge or Free Play. Begin your quest!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 32),

                      ModeButton(
                        text: 'Free Play',
                        imagePath: 'assets/images/freeplay.png',
                        gradientColors: const [kGreenLight, kGreenDark],
                        onPressed: () {
                          print('Mode Free Play Dipilih oleh $userName');
                        },
                      ),
                      const SizedBox(height: 20),

                      ModeButton(
                        text: 'Challenge',
                        imagePath: 'assets/images/challenge.png',
                        gradientColors: const [kOrangeLight, kOrangeDark],
                        onPressed: () {
                          print('Mode Challenge Dipilih oleh $userName');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}