import 'package:flutter/material.dart';
import 'package:quiz/modules/begin/sign_up/models/studen_cadastro_return.dart';
import 'package:quiz/modules/begin/sign_up/models/student_cadastro_body.dart';
import 'package:quiz/modules/begin/sign_up/repo/cadastro_web_service.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/injection_container.dart';
import 'package:quiz/utils/navigation_utils.dart';

class SignUpViewModel extends ChangeNotifier {
  bool _autoValidate = false;
  bool _loading = false;
  String? _nickName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  GlobalKey<FormState> _key = GlobalKey();

  bool get loading => _loading;
  bool get autoValidate => _autoValidate;
  String? get nickname => _nickName;
  String? get password => _password;
  String? get confirmarPassword => _confirmPassword;
  String? get email => _email;
  GlobalKey<FormState> get key => _key;

  setLoading(bool loading) async {
    _loading = loading;
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

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      _email = null; // Reseta o email se for nulo ou vazio
      return "Informe o Email";
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      _email = value; // Atualiza o email se for válido
      return null;
    } else {
      _email = null; // Reseta o email se for inválido
      return "Email Inválido";
    }
  }

  //Descobrir como validar as duas senhas
  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      _password = null; // Reseta a senha se for nula ou vazia
      return "Informe a senha";
    }

    String pattern = r'^(?=.*\d).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      _password = value; // Atualiza a senha se for válida
      return null;
    } else {
      _password = null; // Reseta a senha se for inválida
      return "A senha deve conter oito dígitos e um número";
    }
  }

  String? confirmarValidarSenha(String? value) {
    if (value == null || value.isEmpty) {
      _confirmPassword = null;
      return "Confirme a senha";
    } else {
      if (_password == value) {
        _confirmPassword == value;
        return null;
      } else {
        _confirmPassword =
            null; // Reseta a confirmação de senha se for diferente da senha
        return "As senhas não coincidem";
      }
    }
  }

  sendForm(context) async {
    if (_key.currentState != null) {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();

        var webService = locator<CadastroWebService>();
        if (_nickName != null && _email != null && _password != null) {
          var studentCadastroBody = StudentCadastroRequestBody(
              name: _nickName!, password: _password!, email: _email!);
          setLoading(true);
          var response = await webService.cadastroUser(studentCadastroBody);
          if (response is Success) {
            var userCadastro = response.response as UserCreated;
            if (userCadastro.created == 'true') {
              _showDialog(context,
                  'Usuário cadastrado com sucesso, logue na sua conta'); // teste
              navigateToLoginPage(context);
            } else {
              _showDialog(context, 'Nao foi possivel cadastrar');
            }
          } else if (response is Failure) {
            if (response.code == 200) {
              _showDialog(context, 'Nao foi possivel cadastrar');
            } else {
              _showDialog(context, 'Nao foi possivel cadastrar');
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

  navigateToLoginPage(BuildContext context) {
    backPreviousPage(context);
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
