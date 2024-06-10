import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/change_user/view/change_user_data_screen.dart';
import 'package:quiz/modules/home_navigation/view_model/home_app_view_model.dart';
import 'package:quiz/modules/home_navigation/views/home_app_screen.dart';
import 'package:quiz/modules/quiz_flow/feedback/view/feedback_screen.dart';
import 'package:quiz/modules/quiz_flow/feedback/view_model/feedback_view_model.dart';
import 'package:quiz/modules/quiz_flow/quiz/model/quiz_data.dart';
import 'package:quiz/modules/quiz_flow/quiz/view/quiz_screen.dart';
import 'package:quiz/modules/quiz_flow/quiz/view_model/quiz_view_model.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/view/subjects_screen.dart';
import 'package:quiz/modules/begin/sign_up/view_model/sign_up_view_model.dart';
import 'package:quiz/modules/begin/sign_up/views/sign_up_screen.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/modules/user_exemple/view_models/user_details_viewModel.dart';
import 'package:quiz/modules/user_exemple/views/add_user_screen.dart';
import 'package:quiz/modules/user_exemple/views/user_details_screen.dart';

//testes
void openUserDetails(BuildContext context, UserModel userModel) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => UserDetailsViewModel(userModel),
        child: const UserDetailsScreen(),
      ),
    ),
  );
}

void openAddUser(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddUserScreen()),
  );
}

//gerais
void backPreviousPage(BuildContext context) {
  Navigator.pop(context);
}

void openHomeApp(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => HomeAppPageViewModel(context: context),
        child: HomeAppPage(),
      ),
    ),
  );
}

//cadastro/ login
void openCreateAccount(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => SignUpViewModel(),
        child: const SignupPage(),
      ),
    ),
  );
}

//quiz
void openQuizSubject(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SchoolSubjectScreen()),
  );
}

void openQuizStart(BuildContext context, QuizDataModel quizDataModel) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => QuizViewModel(quizDataModel),
        child: const QuizPageScreen(),
      ),
    ),
  );
}

void openQuizFeedBack(BuildContext context, int score) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => ResultViewModel(score: score),
        child: const ResultPage(),
      ),
    ),
  );
}

// aluno
void openUserChangeDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChangeUserPage()),
  );
}
