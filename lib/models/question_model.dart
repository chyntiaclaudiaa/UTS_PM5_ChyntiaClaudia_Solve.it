class QuestionModel {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  const QuestionModel({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}