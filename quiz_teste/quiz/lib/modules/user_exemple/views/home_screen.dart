import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/components/app_title.dart';
import 'package:quiz/components/user_list_row.dart';
import 'package:quiz/modules/user_exemple/models/user_list_model.dart';
import 'package:quiz/modules/user_exemple/view_models/users_view_model.dart';
import 'package:quiz/modules/user_exemple/views/add_user_screen.dart';
import 'package:quiz/utils/navigation_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<
        UserViewModel>(); //estou me inscrevendo no provider nesse ponto, quando tiver mudancas vou onbeervar
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                openAddUser(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [_ui(userViewModel)],
        ),
      ),
    );
  }

  _ui(UserViewModel userViewModel) {
    if (userViewModel.loading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          backgroundColor: Colors.grey,
          strokeWidth: 5,
        ),
      );
    }
    if (userViewModel.userError != null) {
      return Container();
    }

    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          UserModel userModel = userViewModel.userListModel[index];
          return UserListRow(
              userModel: userModel,
              onTap: () async {
                openUserDetails(context, userModel);
              });
        },
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          height: 10,
        ),
        itemCount: userViewModel.userListModel.length,
      ),
    );
  }
}
