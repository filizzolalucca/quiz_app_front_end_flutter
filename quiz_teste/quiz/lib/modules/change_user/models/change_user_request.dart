import 'dart:convert';

UserChangeRequestBody userChangeRequestBodyFromJson(String str) =>
    UserChangeRequestBody.fromJson(json.decode(str));

String userChangeRequestBodyToJson(UserChangeRequestBody data) =>
    json.encode(data.toJson());

class UserChangeRequestBody {
  int idUsuario;
  String nome;

  UserChangeRequestBody({
    required this.idUsuario,
    required this.nome,
  });

  factory UserChangeRequestBody.fromJson(Map<String, dynamic> json) =>
      UserChangeRequestBody(
        idUsuario: json["id_usuario"],
        nome: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "nome": nome,
      };
}
