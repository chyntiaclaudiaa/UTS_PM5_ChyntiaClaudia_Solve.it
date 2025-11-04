import 'dart:async';
import 'package:flutter/material.dart';
import '../data/quiz_dummy.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  final String userName;

  static const int timePerQuestion = 10;

  QuizProvider({required this.userName});

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _showCorrectness = false;
  int _score = 0;

  Timer? _timer;
  int _secondsRemaining = timePerQuestion;

  VoidCallback? _timesUpCallback;

  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  bool get showCorrectness => _showCorrectness;
  int get score => _score;
  int get secondsRemaining => _secondsRemaining;
  QuestionModel get currentQuestion => quizQuestions[_currentQuestionIndex];
  double get progress => (_currentQuestionIndex + 1) / quizQuestions.length;
  bool get isFinished => _currentQuestionIndex >= quizQuestions.length - 1;

  void startTimer(VoidCallback timesUpCallback) {
    _timesUpCallback = timesUpCallback;
    _timer?.cancel();
    _secondsRemaining = timePerQuestion;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _timesUpCallback?.call();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  void selectAnswer(int index) {
    if (_showCorrectness) return;
    _selectedAnswerIndex = index;
    notifyListeners();
  }

  void checkAnswer() {
    if (_selectedAnswerIndex == null) return;
    _showCorrectness = true;
    if (_selectedAnswerIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }
    cancelTimer();
    notifyListeners();
  }

  void nextQuestion() {
    if (!isFinished) {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _showCorrectness = false;
      _secondsRemaining = timePerQuestion;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswerIndex = null;
    _showCorrectness = false;
    _score = 0;
    _secondsRemaining = timePerQuestion;
    _timer?.cancel();
    notifyListeners();
  }
}
