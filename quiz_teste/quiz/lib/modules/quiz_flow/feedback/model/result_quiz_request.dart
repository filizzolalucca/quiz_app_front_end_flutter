import 'dart:convert';

ResultQuizRequest resultQuizRequestFromJson(String str) =>
    ResultQuizRequest.fromJson(json.decode(str));

String resultQuizRequestToJson(ResultQuizRequest data) =>
    json.encode(data.toJson());

class ResultQuizRequest {
  int idMateria;
  int idUsuario;
  int pontuacao;

  ResultQuizRequest({
    required this.idMateria,
    required this.idUsuario,
    required this.pontuacao,
  });

  factory ResultQuizRequest.fromJson(Map<String, dynamic> json) =>
      ResultQuizRequest(
        idMateria: json["id_materia"],
        idUsuario: json["id_usuario"],
        pontuacao: json["pontuacao"],
      );

  Map<String, dynamic> toJson() => {
        "id_materia": idMateria,
        "id_usuario": idUsuario,
        "pontuacao": pontuacao,
      };
}
