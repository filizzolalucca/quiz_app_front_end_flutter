import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/sign_up/view_model/sign_up_view_model.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpViewModel signUpViewModel = context.watch<SignUpViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  const Text(
                    "Criar sua conta",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                key: signUpViewModel.key,
                child: _formUI(signUpViewModel),
                autovalidateMode: AutovalidateMode.always,
              ),
              Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      signUpViewModel.sendForm();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                      "Criar Conta",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Ja tem uma conta ?"),
                  TextButton(
                      onPressed: () {
                        signUpViewModel.sendForm();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.purple),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//viewModel
  _formUI(SignUpViewModel signUpViewModel) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
              hintText: "Nickname",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          validator: (name) => signUpViewModel.validarNome(name),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
              hintText: "E-mail",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
          validator: (email) => signUpViewModel.validarEmail(email),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Senha",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
          validator: (password) => signUpViewModel.validarSenha(password),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Confirmar Senha",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password)),
          obscureText: true,
          validator: (cpassword) =>
              signUpViewModel.confirmarValidarSenha(cpassword),
        )
      ],
    );
  }
}
