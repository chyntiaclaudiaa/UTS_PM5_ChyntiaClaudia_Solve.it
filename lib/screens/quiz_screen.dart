import 'package:flutter/material.dart';
import 'package:uts_pm5_slove_it/data/quiz_dummy.dart';
import 'package:uts_pm5_slove_it/models/question_model.dart';
import 'package:uts_pm5_slove_it/widgets/answer_option.dart';
import 'package:uts_pm5_slove_it/widgets/main_background.dart';
import 'package:uts_pm5_slove_it/widgets/primary_button.dart';
// import 'score_screen.dart'; // Nanti untuk halaman skor

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

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
              content: Text('Please select an answer!'),
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
        print('Kuis Selesai! Skor: $_score');
        // TODO: Navigasi ke ScoreScreen (Halaman 4)
      }
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
              const SizedBox(height: 40),

              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              ...List.generate(currentQuestion.options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: AnswerOption( // Widget Reusable (Kriteria 3)
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