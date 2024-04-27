import 'package:flutter/material.dart';

class User {
  late String mail;
  late String password;

  User({required this.mail, required this.password});

  User.empty() {
    mail = "";
    password = "";
  }
}
