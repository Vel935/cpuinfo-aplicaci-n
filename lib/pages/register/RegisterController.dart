import 'package:cpuinfo_application/providers/UserProvider.dart';

class RegisterController {
  UserProvider userProvider = UserProvider();
  RegisterController.empty();

  Future<String> createUser(Map<String, dynamic> user) {
    return userProvider.createUser(user);
  }
}
