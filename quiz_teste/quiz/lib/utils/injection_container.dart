import 'package:get_it/get_it.dart';
import 'package:quiz/modules/change_user/repo/change_user_web_service.dart';
import 'package:quiz/modules/begin/sign_in/repo/login_web_service.dart';
import 'package:quiz/modules/begin/sign_up/repo/cadastro_web_service.dart';
import 'package:quiz/modules/quiz_flow/feedback/repo/result_quiz_webservice.dart';
import 'package:quiz/modules/quiz_flow/select_subjects/repo/selected_quiz_webservice.dart';
import 'package:quiz/modules/user_exemple/repo/user_web_services.dart';

final locator = GetIt.instance;

// criar o setUp

void setUp() {
  locator.registerFactory<UserWebService>(() => UserWebService());
  locator.registerFactory<LoginWebService>(() => LoginWebService());
  locator.registerFactory<CadastroWebService>(() => CadastroWebService());
  locator.registerFactory<ChangeUserWebService>(() => ChangeUserWebService());
  locator.registerFactory<SelectQuizWebService>(() => SelectQuizWebService());
  locator.registerFactory<ResultQuizRequestWebService>(
      () => ResultQuizRequestWebService());
}
