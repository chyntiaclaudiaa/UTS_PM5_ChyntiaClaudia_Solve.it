import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uts_pm5_slove_it/providers/user_provider.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/primary_button.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions, required String userName,
  });

  @override
  Widget build(BuildContext context) {
    final String userName = context.watch<UserProvider>().userName;

    final double percentage = score / totalQuestions;

    return MainBackground(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 50.0,
            ),
            child: LayoutBuilder(
              builder: (context, viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: 1.0,
                                  strokeWidth: 15,
                                  backgroundColor: Colors.white.withOpacity(0.1),
                                ),
                                CircularProgressIndicator(
                                  value: percentage,
                                  strokeWidth: 15,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00C6FF)),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Your Score',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        '$score/$totalQuestions',
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Congratulation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Great job, $userName! You Did It',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 80),
                        PrimaryButton(
                          text: 'Back to Home',
                          onPressed: () {
                            context.goNamed('home');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}