import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/begin/sign_in/view_model/sign_in_view_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignInViewModel signInViewModel = context.watch<SignInViewModel>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Consumer<SignInViewModel>(builder: (context, viewModel, child) {
        if (viewModel.loading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              backgroundColor: Colors.grey,
              strokeWidth: 5,
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              Form(
                key: signInViewModel.key,
                child: _inputField(signInViewModel, context),
                autovalidateMode: AutovalidateMode.always,
              ),
              _signup(signInViewModel, context),
            ],
          ),
        );
      })),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Quiz App",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Entre com seus dados"),
      ],
    );
  }

  _inputField(SignInViewModel signInViewModel, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
          validator: (value) => signInViewModel.validarNome(value),
        ),
        const SizedBox(height: 10),
        TextFormField(
            decoration: InputDecoration(
                hintText: "Senha",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.purple.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.password)),
            validator: (value) => signInViewModel.validarSenha(value),
            obscureText: true),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            signInViewModel.sendForm(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.purple,
          ),
          child: const Text(
            "Entrar",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        )
      ],
    );
  }

  _signup(SignInViewModel signInViewModel, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Nao possui cadastro ?"),
        TextButton(
            onPressed: () {
              signInViewModel.navigateToCreateAccount(context);
            },
            child: const Text(
              "Crie agora uma conta",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
