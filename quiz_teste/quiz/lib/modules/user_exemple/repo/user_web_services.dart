
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/modules/user_exemple/repo/api_status.dart';
import 'package:quiz/utils/constants.dart';

abstract class WebServiceType {
  Future<Object> getUsers();
}

class UserWebService extends WebServiceType {
  Future<Object> getUsers() async {
  try {
    var url = Uri.parse(USER_LIST);
    var response = await http.get(url);
    if(200 == response.statusCode) {
      return Success(code: 200, response: userListModelFromJson(response.body));
    }

    return Failure(
      code: USER_INVALID_RESPONSE,
       erorResponse: 'Invalid Response'
       );
  } on HttpException {
    return Failure(code: NO_INTERNET,
     erorResponse: 'No Internet');
  } on FormatException {
    return Failure(code: INVALID_FORMAT,
     erorResponse: 'Invalid Format');
  }
  
   catch (e) {
    return Failure(code: UNKNOWN_ERROR, erorResponse: 'Unknown Error');
  }
  }
}
