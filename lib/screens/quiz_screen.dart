import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uts_pm5_slove_it/data/quiz_dummy.dart';
import 'package:uts_pm5_slove_it/models/question_model.dart';
import 'package:uts_pm5_slove_it/widgets/answer_option.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/primary_button.dart';

class QuizScreen extends StatefulWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _showCorrectness = false;
  int _score = 0;

  void _onAnswerTapped(int index) {
    setState(() {
      _selectedAnswerIndex = index;
      _showCorrectness = false;
    });
  }

  void _onNextTapped() {
    setState(() {
      if (_selectedAnswerIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an answer!', style: TextStyle(fontFamily: 'Poppins')),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (!_showCorrectness) {
        _showCorrectness = true;
        final question = quizQuestions[_currentQuestionIndex];
        if (_selectedAnswerIndex == question.correctAnswerIndex) {
          _score++;
        }
        return;
      }

      _showCorrectness = false;
      _selectedAnswerIndex = null;

      if (_currentQuestionIndex < quizQuestions.length - 1) {
        _currentQuestionIndex++;
      } else {
        context.goNamed(
          'score',
          pathParameters: {'userName': widget.userName},
          extra: {
            'score': _score,
            'totalQuestions': quizQuestions.length,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final QuestionModel currentQuestion = quizQuestions[_currentQuestionIndex];
    final double progress = (_currentQuestionIndex + 1) / quizQuestions.length;

    return MainBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Level ${_currentQuestionIndex + 1}',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 40),

              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
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
                  final bool isCorrect = _selectedAnswerIndex == currentQuestion.correctAnswerIndex;
                  final String correctAnswerText = currentQuestion.options[currentQuestion.correctAnswerIndex];

                  return Text(
                    isCorrect
                        ? "Correct Answer! $correctAnswerText."
                        : "Wrong! The correct answer is $correctAnswerText.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                })
                    : null,
              ),
              const SizedBox(height: 8),

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
