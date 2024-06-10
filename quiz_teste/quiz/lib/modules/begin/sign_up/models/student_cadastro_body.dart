class StudentCadastroRequestBody {
  final String name;
  final String password;
  final String email;

  StudentCadastroRequestBody(
      {required this.name, required this.password, required this.email});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password, "nome": name};
  }
}
