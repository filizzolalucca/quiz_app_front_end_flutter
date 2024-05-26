import 'package:flutter/cupertino.dart';
import 'package:quiz/utils/navigation_utils.dart';

class SignInViewModel extends ChangeNotifier {
  bool autoValidate = false;

  String? nickName;
  String? password;

  GlobalKey<FormState> key = GlobalKey();

  String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      nickName = null; // Reseta o nickname se for nulo ou vazio
      return "Informe o nickname";
    } else {
      nickName = value;
      return null;
    }
  }

  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      password = null; // Reseta a senha se for nula ou vazia
      return "Informe a senha";
    } else {
      password = value;
      return null;
    }
  }

  sendForm() {
    if (key.currentState != null) {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        //aqui vou fazer a conexao com o back
        print("Nome $nickName");
      } else {
        autoValidate = true;
      }
    }
    notifyListeners();
  }

  navigateToCreateAccount(BuildContext context) {
    openCreateAccount(context);
  }
}
