import 'dart:convert';

UserChangeResponseBody userChangeResponseBodyFromJson(String str) =>
    UserChangeResponseBody.fromJson(json.decode(str));

String userChangeResponseBodyToJson(UserChangeResponseBody data) =>
    json.encode(data.toJson());

class UserChangeResponseBody {
  bool edited;

  UserChangeResponseBody({
    required this.edited,
  });

  factory UserChangeResponseBody.fromJson(Map<String, dynamic> json) =>
      UserChangeResponseBody(
        edited: json["edited"],
      );

  Map<String, dynamic> toJson() => {
        "edited": edited,
      };
}
