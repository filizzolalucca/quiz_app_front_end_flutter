import 'dart:convert';

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));

String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  int id;

  UserId({
    required this.id,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
