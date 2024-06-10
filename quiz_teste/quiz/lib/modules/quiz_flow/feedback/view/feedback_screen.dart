import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/quiz_flow/feedback/view_model/feedback_view_model.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ResultViewModel>(builder: (context, viewModel, child) {
      if (viewModel.loading) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            backgroundColor: Colors.grey,
            strokeWidth: 5,
          ),
        );
      }

      int score = viewModel.score;
      bool isSuccessful = viewModel.score >= 6;
      String title = isSuccessful ? 'Parabéns!' : 'Não desanime!';
      String description = isSuccessful
          ? 'Você brilhou no quiz!'
          : 'A pontuação não foi boa, mas basta estudar um pouco mais.';
      Color backgroundColor =
          isSuccessful ? Colors.lightGreenAccent : Colors.redAccent;
      Color textColor = Colors.white;

      return Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: TextStyle(fontSize: 20, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Você acertou $score de 10 perguntas!',
                style: TextStyle(fontSize: 24, color: textColor),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  //Navigator.of(context).pop(); -> tenho que fazer ele voltar no comeco, ver como
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: const Text('Voltar ao Início'),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
