import 'package:flutter/material.dart';

class ResultViewModel extends ChangeNotifier {
  bool _loading = false;
  int score;

  ResultViewModel({required this.score});
  bool get loading => _loading;

  sendResult() async {
    //aqui vou manda pro back o resultado;
  }
}
