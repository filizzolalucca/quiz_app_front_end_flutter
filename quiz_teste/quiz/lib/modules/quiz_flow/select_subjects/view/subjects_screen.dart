import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/materia.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/view/subject_list_row.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/viewModel/subjects_view_model.dart';

class SchoolSubjectScreen extends StatelessWidget {
  const SchoolSubjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body:
            Consumer<SubjectsViewModel>(builder: (context, viewModel, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [_ui(viewModel, context)],
            ),
          );
        })));
  }

  _ui(SubjectsViewModel viewModel, BuildContext context) {
    if (viewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          backgroundColor: Colors.grey,
          strokeWidth: 5,
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemBuilder: (contextList, index) {
          Materia materia = viewModel.materias[index];
          return SubjectListRow(
              materia: materia,
              onTap: () async {
                viewModel.selectSubject(context, materia.id);
              });
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: viewModel.materias.length,
      ),
    );
  }
}
