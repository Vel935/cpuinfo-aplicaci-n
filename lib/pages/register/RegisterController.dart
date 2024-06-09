import 'package:cpuinfo_application/pages/login/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart' as authfb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController {
  GlobalKey<FormState> key;
  BuildContext context;
  UserProvider userProvider = UserProvider();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final firebaseAuthService _auth = firebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  RegisterController({required this.key, required this.context});

  Future<String> createUser(Map<String, dynamic> user) {
    if (!key.currentState!.validate()) return Future.value("");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Usuario registrado con exito'),
        duration: Duration(seconds: 5),
      ),
    );
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

  void signup(String mail, String password, String role) async {
    print("Email: $mail, Password: $password, Role: $role");

    authfb.User? user =
        await _auth.signUpWithEmailAndPassword(mail, password, role);
    print(user);
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'email': mail,
        'role': role,
      });
      print("Usuario registrado con exito");
    } else {
      print("Error al registrar usuario");
    }
  }
}
