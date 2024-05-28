import 'dart:convert';

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));

String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  int id;
  String nome;
  String email;

  UserId({required this.id, required this.email, required this.nome});

  factory UserId.fromJson(Map<String, dynamic> json) =>
      UserId(id: json["id"], nome: json["nome"], email: json["email"]);

  Map<String, dynamic> toJson() => {"id": id, "nome": nome, "email": email};
}
