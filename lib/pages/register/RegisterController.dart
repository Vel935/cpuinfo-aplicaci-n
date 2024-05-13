import 'package:cpuinfo_application/models/user.dart';
import 'package:cpuinfo_application/pages/login/LoginPage.dart';
import 'package:cpuinfo_application/pages/login/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart' as authfb;
import 'package:flutter/material.dart';

class RegisterController {
  GlobalKey<FormState> key;
  BuildContext context;
  UserProvider userProvider = UserProvider();

  final firebaseAuthService _auth = firebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
    //crear el usuario en firebase auth

    //hacer print de todos los usuarios
    //_controller.getAll().then((users) {
    //  users.forEach((element) {
    //    print(element.mail);
    //  });
    //});
    //_signup();
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

  String? validConfirmPasswordField({String? value, required String password}) {
    if (value == null || value.isEmpty) {
      return "El campo es obligatorio.";
    }
    print("contraseña $password");
    print("value $value");

    if (password != value) {
      return "Las contraseñas deben coincidir";
    }

    if (value.length < 8) {
      return "El campo debe tener al menos 8 caracteres.";
    }

    return null;
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signup(mail, password) async {
    print("Email: $mail, Password: $password");

    authfb.User? user = await _auth.signUpWithEmailAndPassword(mail, password);
    print(user);
    if (user != null) {
      print("Usuario registrado con exito");
    } else {
      print("Error al registrar usuario");
    }
  }
}
