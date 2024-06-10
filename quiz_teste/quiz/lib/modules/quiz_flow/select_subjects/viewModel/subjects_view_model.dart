import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/materia.dart';
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

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  selectSubject(context, int id) async {
    //aqui vou selecionar a materia, chamar o back e com o objeto de quiz completo redireciono para tela
  }
}
