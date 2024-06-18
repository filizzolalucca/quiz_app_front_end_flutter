// To parse this JSON data, do
//
//     final selectQuizRequest = selectQuizRequestFromJson(jsonString);

import 'dart:convert';

SelectQuizRequest selectQuizRequestFromJson(String str) =>
    SelectQuizRequest.fromJson(json.decode(str));

String selectQuizRequestToJson(SelectQuizRequest data) =>
    json.encode(data.toJson());

class SelectQuizRequest {
  int idMateria;
  int idUsuario;

  SelectQuizRequest({
    required this.idMateria,
    required this.idUsuario,
  });

  factory SelectQuizRequest.fromJson(Map<String, dynamic> json) =>
      SelectQuizRequest(
        idMateria: json["id_materia"],
        idUsuario: json["id_usuario"],
      );

  Map<String, dynamic> toJson() => {
        "id_materia": idMateria,
        "id_usuario": idUsuario,
      };
}
