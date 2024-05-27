import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        child: UserDetailsScreen(),
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