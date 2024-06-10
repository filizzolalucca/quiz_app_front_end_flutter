import 'dart:convert';

UserCreated userCreatedFromJson(String str) =>
    UserCreated.fromJson(json.decode(str));

String userCreatedToJson(UserCreated data) => json.encode(data.toJson());

class UserCreated {
  String created;

  UserCreated({
    required this.created,
  });

  factory UserCreated.fromJson(Map<String, dynamic> json) => UserCreated(
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "created": created,
      };
}
