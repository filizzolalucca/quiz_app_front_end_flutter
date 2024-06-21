//ViewModel para tela de detalhe de

import 'package:flutter/material.dart';
import 'package:quiz/modules/user_exemple/models/user_error.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';

class UserDetailsViewModel extends ChangeNotifier {
  bool _loading = false;
  UserError? _userError;
  late UserModel _selectedUserModel;

  UserDetailsViewModel(UserModel selectedUserModel) {
    _selectedUserModel = selectedUserModel;
  }


  bool get loading => _loading;
  UserError? get userError => _userError;
  UserModel get selectedUserModel => _selectedUserModel;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setSelectedUserModel(UserModel selectedUserModel) {
    _selectedUserModel = selectedUserModel;
  }

  setUserError(UserError? userError) {
    _userError = userError;
  }

}