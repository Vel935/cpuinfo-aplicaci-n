import 'package:cpuinfo_application/pages/login/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  UserProvider userProvider = UserProvider();
  GlobalKey<FormState> key;
  BuildContext context;
  LoginController({required this.key, required this.context});

  final firebaseAuthService _auth = firebaseAuthService();

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

  Future<bool> signIn(mail, password) async {
    print("Email: $mail, Password: $password");

    User? user = await _auth.signInWithEmailAndPassword(mail, password);
    print(user);
    if (user != null) {
      print("autenticacion exitosa");
    } else {
      print("autenticacion fallida");
    }
    return user != null;
  }

  Future<UserCredential> signInWithGoogle() async {
    return await _auth.signInWithGoogle();
  }
}
