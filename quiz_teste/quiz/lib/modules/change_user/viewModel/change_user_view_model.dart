import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/modules/change_user/models/change_user_request.dart';
import 'package:quiz/modules/change_user/models/change_user_response.dart';
import 'package:quiz/modules/change_user/repo/change_user_web_service.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeUserViewModel extends ChangeNotifier {
  bool _autoValidate = false;
  bool _loading = false;
  String? _nickNameTitle;
  String? _nickName;
  int? _id;
  GlobalKey<FormState> _key = GlobalKey();

  ChangeUserViewModel() {
    _loadUserName();
    _loadUserID();
  }

  bool get loading => _loading;
  bool get autoValidate => _autoValidate;
  String? get nickname => _nickName;
  String? get nickNameTitle => _nickNameTitle;
  GlobalKey<FormState> get key => _key;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nickNameTitle = prefs.getString('user_nickname') ?? "not_found";
    notifyListeners();
  }

  Future<void> _loadUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getInt('user_id') ?? -1;
    notifyListeners();
  }

  Future<void> _saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_nickname', userName);
    _nickNameTitle = userName;
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
        var webService = locator<ChangeUserWebService>();
        if (_nickName != null) {
          var changeUserRequestBody =
              UserChangeRequestBody(idUsuario: _id!, nome: _nickName!);
          setLoading(true);

          var response =
              await webService.changeUserNickname(changeUserRequestBody);
          if (response is Success) {
            var userAlterado = response.response as UserChangeResponseBody;
            if (userAlterado.edited) {
              _showDialog(context, 'Nickname alterado com sucesso');
              _saveUserName(_nickName!);
            } else {
              _showDialog(context, 'Falha em alterar nickname');
            }
          } else if (response is Failure) {
            if (response.code == 200) {
              _showDialog(context, 'Falha em alterar nickname');
            } else {
              _showDialog(context, 'Falha em alterar nickname');
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
