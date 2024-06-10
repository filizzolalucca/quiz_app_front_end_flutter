import 'package:flutter/material.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/materia.dart';

class SubjectListRow extends StatelessWidget {
  final Materia materia;
  final void Function() onTap;

  const SubjectListRow({super.key, required this.materia, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            materia.nome,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
