
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/components/app_title.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';

class UserListRow extends StatelessWidget {
  final UserModel userModel;
  final void Function() onTap;
  UserListRow({required this.userModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
   return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(text: userModel.name,),
        Text(
          userModel.email,
           style: const TextStyle(color: Colors.black),
          ),
      ]
           ),
   );
  }
}