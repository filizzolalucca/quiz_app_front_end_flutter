import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/change_user/view/change_user_data_screen.dart';
import 'package:quiz/modules/home_quiz/view_model/home_app_view_model.dart';
import 'package:quiz/modules/home_quiz/views/home_app_screen.dart';
import 'package:quiz/modules/select_subjects/view/subjects_screen.dart';
import 'package:quiz/modules/sign_up/view_model/sign_up_view_model.dart';
import 'package:quiz/modules/sign_up/views/sign_up_screen.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/modules/user_exemple/view_models/user_details_viewModel.dart';
import 'package:quiz/modules/user_exemple/views/add_user_screen.dart';
import 'package:quiz/modules/user_exemple/views/user_details_screen.dart';

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

void backPreviousPage(BuildContext context) {
  Navigator.pop(context);
}

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

void openQuizStart(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SchoolSubjectScreen()),
  );
}

void openUserChangeDetails(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChangeUserPage()),
  );
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

void openAddUser(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddUserScreen()),
  );
}
