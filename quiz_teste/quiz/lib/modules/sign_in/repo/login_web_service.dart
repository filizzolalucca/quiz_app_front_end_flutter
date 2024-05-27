import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiz/modules/sign_in/models/student_login_body.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/constants.dart';

abstract class WebServiceType {
  Future<Object> loginUser(StudentLoginRequestBody studentLoginRequestBody);
}

class LoginWebService extends WebServiceType {
  @override
  Future<Object> loginUser(
      StudentLoginRequestBody studentLoginRequestBody) async {
    try {
      var url = Uri.parse(USER_LOGIN);
      var response =
          await http.post(url, body: jsonEncode(studentLoginRequestBody));
      if (200 == response.statusCode) {
        return Success(code: 200, response: response);
      }

      return Failure(
          code: USER_INVALID_RESPONSE, erorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, erorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, erorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, erorResponse: 'Unknown Error');
    }
  }
}
