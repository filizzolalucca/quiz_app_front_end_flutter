import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/models/select_quiz_request_model.dart';

import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/constants.dart';

abstract class WebServiceType {
  Future<Object> selectQuizRequest(SelectQuizRequest selectQuizRequest);
}

class SelectQuizWebService extends WebServiceType {
  @override
  Future<Object> selectQuizRequest(SelectQuizRequest selectQuizRequest) async {
    try {
      var url = Uri.parse(SELECT_QUIZ);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(selectQuizRequest.toJson()));
      if (201 == response.statusCode) {
        String responseBody = response.body;

        if (responseBody.isNotEmpty) {
          return Success(
              code: 200, response: quizDataModelFromJson(response.body));
        } else {
          return Failure(
              code: 200, erorResponse: 'Nao foi possivel encontrar um quiz');
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
