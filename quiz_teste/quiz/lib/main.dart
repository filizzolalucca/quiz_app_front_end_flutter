import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/sign_in/view_model/sign_in_view_model.dart';
import 'package:quiz/modules/sign_in/views/sign_in_screen.dart';
import 'package:quiz/modules/sign_up/view_model/sign_up_view_model.dart';
import 'package:quiz/modules/user_exemple/view_models/users_view_model.dart';
import 'package:quiz/utils/injection_container.dart';

void main() {
  runApp(const MyApp());
  setUp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel.initialize()),
        ChangeNotifierProvider(create: (_) => SignInViewModel())
      ],
      child: const MaterialApp(
        title: 'Quiz App',
        home: LoginPage(),
      ),
    );
  }
}
