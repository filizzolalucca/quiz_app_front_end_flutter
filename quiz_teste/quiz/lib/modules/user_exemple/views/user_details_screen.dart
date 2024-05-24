import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/app_title.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/modules/user_exemple/view_models/user_details_viewModel.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen ({Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
     UserDetailsViewModel userDetailsViewModel = context.watch<UserDetailsViewModel>();
     UserModel userModel = userDetailsViewModel.selectedUserModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(userModel.name),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          AppTitle(text: userModel.name,),
          Text(
            userModel.email,
            style: const TextStyle(color: Colors.black),
            ),
        ]) ,
        ),
    );
  }
}