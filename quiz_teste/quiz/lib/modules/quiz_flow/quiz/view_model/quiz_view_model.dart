import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz/modules/quiz_flow/feedback/model/result_quiz_request.dart';
import 'package:quiz/modules/quiz_flow/feedback/model/result_quiz_response.dart';
import 'package:quiz/modules/quiz_flow/feedback/repo/result_quiz_webservice.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/dialog.dart';
import 'package:quiz/utils/injection_container.dart';
import 'package:quiz/utils/navigation_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizViewModel extends ChangeNotifier {
  bool _loading = false;
  late QuizDataModel _quizDataModel;
  int _currentQuestionIndex = 0;
  int _currentScore = 0;
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;
  late int _idMateria;
  int? _id;

  QuizViewModel(QuizDataModel quizDataModel, int idMateria) {
    _quizDataModel = quizDataModel;
    _idMateria = idMateria;
    _loadUserID();
  }

  bool get loading => _loading;
  QuizDataModel get quizDataModel => _quizDataModel;
  int get idMateria => _idMateria;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get currentScore => _currentScore;
  int? get selectedAswerIndex => _selectedAnswerIndex;

  answerQuestion(bool isCorrect, int answerIndex, context) async {
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
        //chamaro back -> falta;
        sendResult(context, currentScore);

        //Navegar para tela de feedBack com o score
        openQuizFeedBack(context, currentScore, quizDataModel.ajuda);
      }
    });

    notifyListeners();
  }

  sendResult(
    context,
    int score,
  ) async {
    var webService = locator<ResultQuizRequestWebService>();
    if (_id != null) {
      var resultQuizRequest = ResultQuizRequest(
          idMateria: idMateria, idUsuario: _id!, pontuacao: score);
      var response = await webService.resultQuizRequest(resultQuizRequest);
      if (response is Success) {
        setLoading(false);
        var resultadoEnviado = response.response as ResultQuizResponse;
        if (resultadoEnviado.valido) {
          DialogUtils.showDialogAlert(context, 'Pontuacao enviada com sucesso');
        } else {
          DialogUtils.showDialogAlert(
              context, 'Falha em Enviar o Quiz, Sentimos muito');
        }
      } else if (response is Failure) {
        setLoading(false);
        if (response.code == 200) {
          DialogUtils.showDialogAlert(
              context, 'Falha em Enviar o Quiz, Sentimos muito');
        } else {
          DialogUtils.showDialogAlert(
              context, 'Falha em envir o Quiz, Sentimos muito');
        }
      }
    } else {
      setLoading(false);
      DialogUtils.showDialogAlert(
          context, 'Falha em enviar o Quiz, Sentimos muito');
    }
    notifyListeners();
  }

  Future<void> _loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getInt('user_id') ?? -1;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }
}
