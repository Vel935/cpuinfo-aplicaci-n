import 'package:flutter/material.dart';

class User {
  late String mail;
  late String password;

  User({required this.mail, required this.password});

  User.empty() {
    mail = "";
    password = "";
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      mail: map['mail'],
      password: map['password'],
    );
    // Implementacion del metodo fromMap...
  }
}
