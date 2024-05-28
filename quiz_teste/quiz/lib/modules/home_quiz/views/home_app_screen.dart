import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/modules/change_user/viewModel/change_user_view_model.dart';
import 'package:quiz/modules/home_quiz/view_model/home_app_view_model.dart';

class HomeAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Consumer<HomeAppPageViewModel>(
        builder: (context, viewModel, child) {
          return IndexedStack(
            index: viewModel.selectedIndex,
            children: viewModel.selectedWidgets,
          );
        },
      ),
      bottomNavigationBar: Consumer<HomeAppPageViewModel>(
        builder: (context, viewModel, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
            ],
            currentIndex: viewModel.selectedIndex,
            selectedItemColor: Color.fromARGB(255, 121, 0, 93),
            onTap: (index) {
              viewModel.onItemTapped(index);
              if (index == 1) {
                final changeUserViewModel = context.read<ChangeUserViewModel>();
                changeUserViewModel.loadData();
              }
            },
          );
        },
      ),
    );
  }
}
