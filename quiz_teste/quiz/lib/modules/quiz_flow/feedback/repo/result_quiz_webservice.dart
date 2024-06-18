import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:quiz/modules/quiz_flow/feedback/model/result_quiz_request.dart';
import 'package:quiz/modules/quiz_flow/feedback/model/result_quiz_response.dart';

import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/constants.dart';

abstract class WebServiceType {
  Future<Object> resultQuizRequest(ResultQuizRequest resultQuizRequest);
}

class ResultQuizRequestWebService extends WebServiceType {
  @override
  Future<Object> resultQuizRequest(ResultQuizRequest resultQuizRequest) async {
    try {
      var url = Uri.parse(RESULT_QUIZ);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(resultQuizRequest.toJson()));
      if (201 == response.statusCode) {
        String responseBody = response.body;

        if (responseBody.isNotEmpty) {
          return Success(
              code: 200, response: resultQuizResponseFromJson(response.body));
        } else {
          return Failure(
              code: 200,
              erorResponse:
                  'Nao foi possivel enviar a pontuacao, tente novamente mais tarde');
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
