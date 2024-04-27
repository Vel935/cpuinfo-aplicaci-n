import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cpuinfo_application/controller/userProvider.dart';
import 'package:cpuinfo_application/models/user.dart';
import 'package:flutter/material.dart';

User newTask(String mail, String password) {
  return User(mail: mail, password: password);
}

void saveUser(GlobalKey<FormState> _key, User user, UserProvider provider) {
  // Valido el formulario
  if (_key.currentState!.validate()) {
    // Agregar a la lista del provider
    provider.addUser(user);
  }
}

class UserController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'users';

  Future<String> create(Map<String, dynamic> user) async {
    DocumentReference response = await db.collection(collection).add(user);
    return response.id;
  }

  Future<void> createWithId(Map<String, dynamic> user, String id) async {
    await db.collection(collection).doc(id).set(user);
  }

  Future<void> remove(String id) async {
    await db.collection(collection).doc(id).delete();
  }
}
