import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_dummy.dart';
import '../providers/quiz_provider.dart';
import '../widgets/main_background.dart';
import '../widgets/answer_option.dart';
import '../widgets/primary_button.dart';

class ChallengeScreen extends StatefulWidget {
  final String userName;
  const ChallengeScreen({super.key, required this.userName});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late QuizProvider quiz;

  @override
  void initState() {
    super.initState();
    quiz = QuizProvider(userName: widget.userName);
    quiz.startTimer(() => _showTimesUpDialog(context, quiz));
  }

  void _showTimesUpDialog(BuildContext context, QuizProvider quiz) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFF1F2937),
        title: const Center(
          child: Icon(Icons.timer_off_outlined, color: Colors.orangeAccent, size: 50),
        ),
        content: const Text(
          "Time's Up! Your answer is marked as incorrect.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (!quiz.isFinished) {
                quiz.nextQuestion();
                quiz.startTimer(() => _showTimesUpDialog(context, quiz));
              } else {
                quiz.cancelTimer();
                context.goNamed(
                  'score',
                  pathParameters: {'userName': quiz.userName},
                  extra: {
                    'score': quiz.score,
                    'totalQuestions': quizQuestions.length,
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF00C6FF), Color(0xFF0073B9)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: const Text(
                  "Next Question",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: quiz,
      child: Consumer<QuizProvider>(
        builder: (context, quiz, _) {
          return MainBackground(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text('Level ${quiz.currentQuestionIndex + 1}'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LinearProgressIndicator(
                        value: quiz.progress,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: quiz.secondsRemaining / QuizProvider.timePerQuestion,
                                strokeWidth: 8,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  quiz.secondsRemaining < 5 ? Colors.red : Colors.white,
                                ),
                              ),
                              Center(
                                child: Text(
                                  quiz.secondsRemaining.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        quiz.currentQuestion.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(height: 24),
                      ...List.generate(quiz.currentQuestion.options.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: AnswerOption(
                            text: quiz.currentQuestion.options[index],
                            isSelected: index == quiz.selectedAnswerIndex,
                            isCorrect: index == quiz.currentQuestion.correctAnswerIndex,
                            showCorrectness: quiz.showCorrectness,
                            onTap: () => quiz.selectAnswer(index),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      if (quiz.showCorrectness)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            quiz.selectedAnswerIndex == quiz.currentQuestion.correctAnswerIndex
                                ? "Correct Answer! ${quiz.currentQuestion.options[quiz.currentQuestion.correctAnswerIndex]}."
                                : "Wrong! The correct answer is ${quiz.currentQuestion.options[quiz.currentQuestion.correctAnswerIndex]}.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: quiz.selectedAnswerIndex == quiz.currentQuestion.correctAnswerIndex
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      PrimaryButton(
                        text: quiz.showCorrectness ? 'Next' : 'Check Answer',
                        onPressed: () {
                          if (!quiz.showCorrectness) {
                            if (quiz.selectedAnswerIndex == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select an answer!'),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                              return;
                            }
                            quiz.checkAnswer();
                          } else {
                            if (!quiz.isFinished) {
                              quiz.nextQuestion();
                              quiz.startTimer(() => _showTimesUpDialog(context, quiz));
                            } else {
                              quiz.cancelTimer();
                              context.goNamed(
                                'score',
                                pathParameters: {'userName': quiz.userName},
                                extra: {
                                  'score': quiz.score,
                                  'totalQuestions': quizQuestions.length,
                                },
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
