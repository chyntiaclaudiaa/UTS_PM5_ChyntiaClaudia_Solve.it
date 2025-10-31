import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showCorrectness;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showCorrectness,
    required this.onTap,
  });

  Widget _buildButtonContent() {
    Color backgroundColor = Colors.white;
    Color textColor = Colors.black;
    Widget? trailingIcon;

    if (showCorrectness) {
      if (isCorrect) {
        backgroundColor = Colors.green;
        textColor = Colors.white;
        trailingIcon = const Icon(Icons.check_circle, color: Colors.white);
      } else if (isSelected) {
        backgroundColor = Colors.red;
        textColor = Colors.white;
        trailingIcon = const Icon(Icons.cancel, color: Colors.white);
      } else {
        backgroundColor = Colors.white.withOpacity(0.5);
        textColor = Colors.black.withOpacity(0.5);
      }
    } else if (isSelected) {
      backgroundColor = Colors.white.withOpacity(0.8);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 10),
            trailingIcon,
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showCorrectness ? null : onTap,
      child: _buildButtonContent(),
    );
  }
}