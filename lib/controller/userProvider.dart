import 'package:cpuinfo_application/models/cpus.dart';
import 'package:cpuinfo_application/models/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  // Lista privada
  List<User> _users = [];

// Lista pública
  List<User> get users => _users;

  addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void deleteUser(User user) {
    _users.remove(user);
    notifyListeners();
  }
}
