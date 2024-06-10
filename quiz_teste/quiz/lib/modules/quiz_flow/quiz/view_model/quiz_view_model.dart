import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';

class QuizViewModel extends ChangeNotifier {
  bool _loading = false;
  late QuizDataModel _quizDataModel;
  int _currentQuestionIndex = 0;
  int _currentScore = 0;
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;

  QuizViewModel(QuizDataModel quizDataModel) {
    _quizDataModel = quizDataModel;
  }

  bool get loading => _loading;
  QuizDataModel get quizDataModel => _quizDataModel;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get currentScore => _currentScore;
  int? get selectedAswerIndex => _selectedAnswerIndex;

  answerQuestion(bool isCorrect, int answerIndex) async {
    if (_hasAnswered) return; // Prevent answering multiple times

    _hasAnswered = true;
    _selectedAnswerIndex = answerIndex;

    if (isCorrect) {
      _currentScore++;
      Fluttertoast.showToast(
        msg: "Parabéns, você acertou!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Que pena, você errou!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < _quizDataModel.questions.length - 1) {
        _currentQuestionIndex++;
        _hasAnswered = false;
        _selectedAnswerIndex = null;
        notifyListeners();
      } else {
        //Navegar para tela de feedBack com o score
      }
    });

    notifyListeners();
  }
}
