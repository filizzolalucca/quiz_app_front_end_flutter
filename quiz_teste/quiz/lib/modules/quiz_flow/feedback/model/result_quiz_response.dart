import 'dart:convert';

ResultQuizResponse resultQuizResponseFromJson(String str) =>
    ResultQuizResponse.fromJson(json.decode(str));

String resultQuizResponseToJson(ResultQuizResponse data) =>
    json.encode(data.toJson());

class ResultQuizResponse {
  bool valido;

  ResultQuizResponse({
    required this.valido,
  });

  factory ResultQuizResponse.fromJson(Map<String, dynamic> json) =>
      ResultQuizResponse(
        valido: json["valido"],
      );

  Map<String, dynamic> toJson() => {
        "valido": valido,
      };
}
