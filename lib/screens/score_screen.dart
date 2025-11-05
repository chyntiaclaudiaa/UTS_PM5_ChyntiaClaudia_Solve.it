import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/primary_button.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String userName;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.userName,
  });

  String getFeedback() {
    final double percentage = score / totalQuestions;
    if (percentage == 1) return "Perfect!";
    if (percentage >= 0.75) return "Great job!";
    if (percentage >= 0.5) return "Good effort!";
    return "Keep practicing!";
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = score / totalQuestions;

    return MainBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, viewportConstraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 50.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight - 50.0 * 2,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
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
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          '$score/$totalQuestions',
                                          style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
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

                          Text(
                            'Congratulation!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${getFeedback()} Great job, $userName! You Did It',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 80),

                      PrimaryButton(
                        text: 'Back to Home',
                        onPressed: () {
                          context.goNamed(
                            'home',
                            pathParameters: {'userName': userName},
                          );
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
    );
  }
}
