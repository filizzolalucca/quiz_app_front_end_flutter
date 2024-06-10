import 'package:flutter/material.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';

class AnswerRow extends StatelessWidget {
  final Answer answer;
  final bool isSelected;
  final bool isCorrect;
  final void Function() onTap;

  const AnswerRow({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCorrect ? Colors.green : Colors.red)
              : Colors.purple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          answer.resposta,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
