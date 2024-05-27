import 'dart:convert';
import 'dart:io';

import 'package:quiz/modules/sign_up/models/studen_cadastro_return.dart';
import 'package:quiz/modules/sign_up/models/student_cadastro_body.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class WebServiceType {
  Future<Object> cadastroUser(
      StudentCadastroRequestBody studentCadastroRequestBody);
}

class CadastroWebService extends WebServiceType {
  @override
  Future<Object> cadastroUser(
      StudentCadastroRequestBody studentCadastroRequestBody) async {
    try {
      var url = Uri.parse(USER_CADASTRO);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(studentCadastroRequestBody.toJson()));
      if (201 == response.statusCode) {
        String responseBody = response.body;

        if (responseBody.isNotEmpty) {
          return Success(
              code: 200, response: userCreatedFromJson(response.body));
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
