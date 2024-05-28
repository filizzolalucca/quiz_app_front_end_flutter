import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUserViewModel extends ChangeNotifier {
  bool _autoValidate = false;
  bool _loading = false;
  String? _nickName;
  GlobalKey<FormState> _key = GlobalKey();

  ChangeUserViewModel() {
    _loadUserName();
  }

  bool get loading => _loading;
  bool get autoValidate => _autoValidate;
  String? get nickname => _nickName;
  GlobalKey<FormState> get key => _key;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nickName = prefs.getString('user_nickname') ?? "not_found";
    notifyListeners();
  }

  Future<void> _saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_nickname', userName);
    _nickName = userName;
    notifyListeners();
  }

  String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      _nickName = null; // Reseta o nickname se for nulo ou vazio
      return "Informe o nickname";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      _nickName = value; // Atualiza o nickname se for válido
      return null;
    } else {
      _nickName = null; // Reseta o nickname se for inválido
      return "O nickname deve conter caracteres de a-z ou A-Z";
    }
  }

  sendForm(context) async {
    if (key.currentState != null) {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        //chamar requisicao - proximo pr
      } else {
        _showDialog(
            context, 'Confira se esta preenchendo os campos corretamente');
        _autoValidate = true;
      }
    }
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
}
