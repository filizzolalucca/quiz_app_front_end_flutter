class StudentLoginRequestBody {
  final String name;
  final String password;

  StudentLoginRequestBody({required this.name, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": name,
      "password": password,
    };
  }
}
