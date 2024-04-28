import 'package:cpuinfo_application/providers/UserProvider.dart';

class LoginController {
  UserProvider userProvider = UserProvider();

  LoginController.empty();

  Future<bool> login(String mail, String password) {
    return userProvider.login(mail, password);
  }
}
