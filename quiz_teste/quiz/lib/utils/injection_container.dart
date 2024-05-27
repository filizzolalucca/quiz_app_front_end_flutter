import 'package:get_it/get_it.dart';
import 'package:quiz/modules/sign_in/repo/login_web_service.dart';
import 'package:quiz/modules/sign_up/repo/cadastro_web_service.dart';
import 'package:quiz/modules/user_exemple/repo/user_web_services.dart';

final locator = GetIt.instance;

// criar o setUp

void setUp() {
  locator.registerFactory<UserWebService>(() => UserWebService());
  locator.registerFactory<LoginWebService>(() => LoginWebService());
  locator.registerFactory<CadastroWebService>(() => CadastroWebService());
}
