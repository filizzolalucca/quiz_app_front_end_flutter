import 'package:flutter/material.dart';
import 'package:quiz/utils/navigation_utils.dart';

class ResultViewModel extends ChangeNotifier {
  bool _loading = false;
  int score;

  ResultViewModel({required this.score});
  bool get loading => _loading;

  sendResult(context) async {
    backPreviousPage(context);
    backPreviousPage(context);
    //aqui vou manda pro back o resultado;
  }
}
