import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiz/modules/change_user/models/change_user_request.dart';
import 'package:quiz/modules/change_user/models/change_user_response.dart';
import 'package:quiz/utils/api_status.dart';
import 'package:quiz/utils/constants.dart';

abstract class WebServiceType {
  Future<Object> changeUserNickname(
      UserChangeRequestBody userChangeRequestBody);
}

class ChangeUserWebService extends WebServiceType {
  @override
  Future<Object> changeUserNickname(
      UserChangeRequestBody userChangeRequestBody) async {
    try {
      var url = Uri.parse(USER_CHANGE);
      var response = await http.post(url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(userChangeRequestBody.toJson()));
      print(response.statusCode);
      print(response.body);
      if (201 == response.statusCode) {
        String responseBody = response.body;

        if (responseBody.isNotEmpty) {
          return Success(
              code: 200,
              response: userChangeResponseBodyFromJson(response.body));
        } else {
          return Failure(
              code: 200, erorResponse: 'Nao foi possivel alterar os dados');
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
