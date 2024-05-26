import 'package:flutter/material.dart';
import 'package:quiz/utils/navigation_utils.dart';

class SignUpViewModel extends ChangeNotifier {
  bool autoValidate = false;
  String? nickName;
  String? email;
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> key = GlobalKey();

  String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      nickName = null; // Reseta o nickname se for nulo ou vazio
      return "Informe o nickname";
    }
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      nickName = value; // Atualiza o nickname se for válido
      return null;
    } else {
      nickName = null; // Reseta o nickname se for inválido
      return "O nickname deve conter caracteres de a-z ou A-Z";
    }
  }

  String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      email = null; // Reseta o email se for nulo ou vazio
      return "Informe o Email";
    }

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      email = value; // Atualiza o email se for válido
      return null;
    } else {
      email = null; // Reseta o email se for inválido
      return "Email Inválido";
    }
  }

  //Descobrir como validar as duas senhas
  String? validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      password = null; // Reseta a senha se for nula ou vazia
      return "Informe a senha";
    }

    String pattern = r'^(?=.*\d).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value)) {
      password = value; // Atualiza a senha se for válida
      return null;
    } else {
      password = null; // Reseta a senha se for inválida
      return "A senha deve conter oito dígitos e um número";
    }
  }

  String? confirmarValidarSenha(String? value) {
    if (value == null || value.isEmpty) {
      confirmPassword = null;
      return "Confirme a senha";
    } else {
      if (password == value) {
        confirmPassword == value;
        return null;
      } else {
        confirmPassword =
            null; // Reseta a confirmação de senha se for diferente da senha
        return "As senhas não coincidem";
      }
    }
  }

  sendForm() {
    if (key.currentState != null) {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        //aqui vou fazer a conexao com o back
        print("Nome $nickName");
        print("Email $email");
      } else {
        autoValidate = true;
      }
    }
    notifyListeners();
  }

  navigateToLoginPage(BuildContext context) {
    backPreviousPage(context);
  }
}
