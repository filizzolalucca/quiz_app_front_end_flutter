import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/modules/sign_in/models/student_login_body.dart';
import 'package:quiz/modules/sign_in/repo/login_web_service.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/injection_container.dart';
import 'package:quiz/utils/navigation_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInViewModel extends ChangeNotifier {
  bool _autoValidate = false;
  bool _loading = false;
  String? _nickName;
  String? _password;
  GlobalKey<FormState> _key = GlobalKey();

  bool get loading => _loading;
  bool get autoValidate => _autoValidate;
  String? get nickname => _nickName;
  String? get password => _password;
  GlobalKey<FormState> get key => _key;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      _nickName = null; // Reseta o nickname se for nulo ou vazio
      return "Informe o email";
    } else {
      _nickName = value;
      return null;
    }
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      _password = null; // Reseta a senha se for nula ou vazia
      return "Informe a senha";
    } else {
      _password = value;
      return null;
    }
  }

  sendForm(context) async {
    if (key.currentState != null) {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        //aqui vou fazer a conexao com o back

        var webService = locator<LoginWebService>();
        if (_nickName != null && _password != null) {
          var studentLoginRequestBody =
              StudentLoginRequestBody(name: _nickName!, password: _password!);
          setLoading(true);

          var response = await webService.loginUser(studentLoginRequestBody);
          if (response is Success) {
            var userId = response.response as String?;
            print(userId.toString());
            if (userId is String) {
              //await _saveUserId(userId);
              print("e double");
              // Navegar para a próxima tela ou exibir uma mensagem de sucesso
              _showDialog(context, 'Usuário salvo'); // teste
            } else {
              _showDialog(context, 'Usuário não encontrado');
            }
          } else if (response is Failure) {
            if (response.code == 200) {
              _showDialog(context, 'Usuario nao encontrado');
            } else {
              _showDialog(context, 'Usuario nao encontrado');
            }
          }
          setLoading(false);
        }
      } else {
        _showDialog(
            context, 'Confira se esta preenchendo os campos corretamente');
        _autoValidate = true;
      }
    }
    notifyListeners();
  }

  navigateToCreateAccount(BuildContext context) {
    openCreateAccount(context);
  }

  Future<void> _saveUserId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
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
