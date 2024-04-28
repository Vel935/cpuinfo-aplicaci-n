import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:flutter/material.dart';

class LoginController {
  UserProvider userProvider = UserProvider();
  GlobalKey<FormState> key;
  BuildContext context;
  LoginController({required this.key, required this.context});

  Future<bool> login(String mail, String password) {
    if (!key.currentState!.validate()) return Future.value(false);
    return userProvider.login(mail, password);
  }

  String? validEmailField(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return "Por favor, ingresa un correo electrónico válido.";
    }

    return null;
  }

  String? validField(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }
    return null;
  }
}
