import 'package:flutter/cupertino.dart';
import 'package:quiz/modules/change_user/view/change_user_data_screen.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/view/subjects_screen.dart';

class HomeAppPageViewModel extends ChangeNotifier {
  BuildContext context;
  HomeAppPageViewModel({required this.context});
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    SchoolSubjectScreen(),
    ChangeUserPage()
  ];

  List<Widget> get selectedWidgets => _widgetOptions;

  Widget get selectedWidget => _widgetOptions[_selectedIndex];
}
