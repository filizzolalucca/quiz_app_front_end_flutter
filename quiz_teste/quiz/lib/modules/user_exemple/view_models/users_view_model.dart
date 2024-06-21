import 'package:flutter/material.dart';
import 'package:quiz/modules/user_exemple/models/user_error.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/modules/user_exemple/repo/user_web_services.dart';
import 'package:quiz/utils/injection_container.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserModel> _userListModel = [];
  UserError? _userError;
  UserModel? _addingUser;

  UserViewModel.initialize() {
    getUsers();
  }

  bool get loading => _loading;
  UserError? get userError => _userError;
  List<UserModel> get userListModel => _userListModel;
  UserModel? get addingUser => _addingUser;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError? userError) {
    _userError = userError;
  }

  getUsers() async {
    setLoading(true);
    var webService = locator<UserWebService>();
    var response = await webService.getUsers();
    if (response is Success) {
      setUserListModel(response.response as List<UserModel>);
    }

    if (response is Failure) {
      UserError userError = UserError(
        code: response.code,
        message: response.erorResponse.toString(), //Olhar isso
      );
      setUserError(userError);
    }

    setLoading(false);
  }
}
