import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uts_pm5_slove_it/data/quiz_dummy.dart';
import 'package:uts_pm5_slove_it/models/question_model.dart';
import 'package:uts_pm5_slove_it/widgets/answer_option.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/primary_button.dart';

class ChallengeScreen extends StatefulWidget {
  final String userName;
  const ChallengeScreen({super.key, required this.userName});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _showCorrectness = false;
  int _score = 0;

  Timer? _timer;
  static const int _timePerQuestion = 10;
  int _secondsRemaining = _timePerQuestion;


  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showTimesUpDialog() {
    _timer?.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFF1F2937),
          title: const Center(
            child: Icon(
              Icons.timer_off_outlined,
              color: Colors.orangeAccent,
              size: 50,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Time's Up!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your answer is marked as incorrect.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _goToNextQuestion(isTimeUp: true);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                elevation: 5,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C6FF), Color(0xFF0073B9)],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: const Text(
                      "Next Question",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = _timePerQuestion;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _showTimesUpDialog();
      }
    });
  }

  void _onAnswerTapped(int index) {
    if (_showCorrectness) return;

    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _goToNextQuestion({bool isTimeUp = false}) {
    setState(() {
      if (!isTimeUp && _selectedAnswerIndex == quizQuestions[_currentQuestionIndex].correctAnswerIndex) {
        _score++;
      }

      _showCorrectness = false;
      _selectedAnswerIndex = null;

      if (_currentQuestionIndex < quizQuestions.length - 1) {
        _currentQuestionIndex++;
        _startTimer();
      } else {
        _timer?.cancel();

        // --- 3. PERBAIKI NAVIGASI (MENGGUNAKAN GO_ROUTER) ---
        context.goNamed(
          'score',
          pathParameters: {'userName': widget.userName},
          extra: {
            'score': _score,
            'totalQuestions': quizQuestions.length,
          },
        );
        // --- AKHIR PERBAIKAN ---
      }
    });
  }

  void _onNextTapped() {
    setState(() {
      if (_selectedAnswerIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an answer!'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (!_showCorrectness) {
        _timer?.cancel();
        _showCorrectness = true;
        return;
      }

      _goToNextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuestionModel currentQuestion = quizQuestions[_currentQuestionIndex];
    final double progress = (_currentQuestionIndex + 1) / quizQuestions.length;

    return MainBackground(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Level ${_currentQuestionIndex + 1}'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),

              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: _secondsRemaining / _timePerQuestion,
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            _secondsRemaining < 5 ? Colors.red : Colors.white
                        ),
                      ),
                      Center(
                        child: Text(
                          _secondsRemaining.toString().padLeft(2, '0'),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              ...List.generate(currentQuestion.options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnswerOption(
                    text: currentQuestion.options[index],
                    isSelected: index == _selectedAnswerIndex,
                    isCorrect: index == currentQuestion.correctAnswerIndex,
                    showCorrectness: _showCorrectness,
                    onTap: () => _onAnswerTapped(index),
                  ),
                );
              }),

              Container(
                height: 40.0,
                alignment: Alignment.center,
                child: _showCorrectness
                    ? Builder(builder: (context) {
                  if (_timer?.isActive ?? false) {
                    return const SizedBox.shrink();
                  }

                  final bool isCorrect = _selectedAnswerIndex == currentQuestion.correctAnswerIndex;
                  final String correctAnswerText = currentQuestion.options[currentQuestion.correctAnswerIndex];

                  return Text(
                    isCorrect
                        ? "Correct Answer! $correctAnswerText."
                        : "Wrong! The correct answer is $correctAnswerText.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                })
                    : null,
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: _showCorrectness ? 'Next' : 'Check Answer',
                onPressed: _onNextTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}