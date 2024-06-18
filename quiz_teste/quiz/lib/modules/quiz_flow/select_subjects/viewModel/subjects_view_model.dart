import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/materia.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/select_quiz_request_model.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/repo/selected_quiz_webservice.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/dialog.dart';
import 'package:quiz/utils/injection_container.dart';
import 'package:quiz/utils/navigation_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsViewModel extends ChangeNotifier {
  bool _loading = false;
  int? _id;

  final List<Materia> _materias = [
    Materia(id: 1, nome: "Grandeza Proporcional"),
    Materia(id: 3, nome: "Aritmética"),
    Materia(id: 2, nome: "Função"),
    Materia(id: 4, nome: "Geometria Plana"),
  ];

  bool get loading => _loading;
  int? get id => _id;
  List<Materia> get materias => _materias;

  SubjectsViewModel() {
    _loadUserID();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<void> _loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getInt('user_id') ?? -1;
    notifyListeners();
  }

  selectSubject(context, int idMateria) async {
    var webService = locator<SelectQuizWebService>();

    if (id != null) {
      setLoading(true);

      var response = await webService.selectQuizRequest(
          SelectQuizRequest(idMateria: idMateria, idUsuario: id!));

      if (response is Success) {
        setLoading(false);
        var quizData = response.response as QuizDataModel;
        openQuizStart(context, quizData, idMateria);
      } else if (response is Failure) {
        if (response.code == 200) {
          DialogUtils.showDialogAlert(
              context, 'Falha em retornar o Quiz, Sentimos muito');
        } else {
          DialogUtils.showDialogAlert(
              context, 'Falha em retornar o Quiz, Sentimos muito');
        }
      }
    } else {
      DialogUtils.showDialogAlert(
          context, 'Falha em retornar o Quiz, Sentimos muito');
    }
    setLoading(false);
    notifyListeners();
  }
}
