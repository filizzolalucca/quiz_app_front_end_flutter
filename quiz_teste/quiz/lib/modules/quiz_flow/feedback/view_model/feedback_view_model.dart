import 'package:flutter/material.dart';
import 'package:quiz/utils/dialog.dart';
import 'package:quiz/utils/navigation_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultViewModel extends ChangeNotifier {
  bool _loading = false;
  int score;
  String link;

  ResultViewModel({required this.score, required this.link});
  bool get loading => _loading;

  backToBegin(context) async {
    backPreviousPage(context);
    backPreviousPage(context);
  }

  openLink(context) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      DialogUtils.showDialogAlert(context, "Nao foi possivel abrir esse link");
    }
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }
}
