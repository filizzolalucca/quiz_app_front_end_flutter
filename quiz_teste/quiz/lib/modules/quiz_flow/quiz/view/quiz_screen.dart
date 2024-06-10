import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';
import 'package:quiz/modules/quiz_flow/quiz/view/aswer_list_row.dart';
import 'package:quiz/modules/quiz_flow/quiz/view_model/quiz_view_model.dart';

class QuizPageScreen extends StatelessWidget {
  const QuizPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<QuizViewModel>(builder: (context, viewModel, child) {
      Question question =
          viewModel.quizDataModel.questions[viewModel.currentQuestionIndex];
      if (viewModel.loading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            backgroundColor: Colors.grey,
            strokeWidth: 5,
          ),
        );
      }

      return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    Text(
                      question.question,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ...question.answers.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Answer answer = entry.value;
                      return Column(children: [
                        AnswerRow(
                          answer: answer,
                          isSelected: viewModel.selectedAswerIndex == idx,
                          isCorrect: answer.correta,
                          onTap: () =>
                              viewModel.answerQuestion(answer.correta, idx),
                        ),
                        const SizedBox(height: 10),
                      ]);
                    }).toList(),
                  ])));
    }));
  }
}
