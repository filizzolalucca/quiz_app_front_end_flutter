import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/user_exemple/view_models/users_view_model.dart';

class AddUserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>(); //estou me inscrevendo no provider nesse ponto, quando tiver mudancas vou onbeervar

    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Container(
        child:  Column(children: [
          TextFormField(
            onChanged: (val) async {},
            //userViewModel.addingUser?.name = val;
          )
        ]),
      ),
    );
  }
}