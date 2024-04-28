import 'package:cpuinfo_application/pages/login/LoginPage.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:flutter/material.dart';

class RegisterController {
  GlobalKey<FormState> key;
  BuildContext context;
  UserProvider userProvider = UserProvider();

  RegisterController({required this.key, required this.context});

  Future<String> createUser(Map<String, dynamic> user) {
    if (!key.currentState!.validate()) return Future.value("");
    //mostrar un mensaje de exito en el registro
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuario registrado con exito'),
        duration: Duration(seconds: 5),
      ),
    );
    //hacer print de todos los usuarios
    //_controller.getAll().then((users) {
    //  users.forEach((element) {
    //    print(element.mail);
    //  });
    //});
    Navigator.pop(context, "login");
    return userProvider.createUser(user);
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

  String? validPasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }

    if (value.length < 8) {
      return "El campo debe tener al menos 8 caracteres.";
    }

    return null;
  }
}
