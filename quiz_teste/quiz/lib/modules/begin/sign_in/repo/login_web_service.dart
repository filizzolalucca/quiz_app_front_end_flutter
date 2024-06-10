import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiz/modules/begin/sign_in/models/studen_login_id.dart';
import 'package:quiz/modules/begin/sign_in/models/student_login_body.dart';
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
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(studentLoginRequestBody.toJson()));
      if (201 == response.statusCode) {
        String responseBody = response.body;

        if (responseBody.isNotEmpty) {
          return Success(code: 200, response: userIdFromJson(response.body));
        } else {
          return Failure(code: 200, erorResponse: 'Usuário não encontrado');
        }
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
