import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;

  final String collection = 'users';

  Future<String> createUser(Map<String, dynamic> user) async {
    //metodo para añadir un usuario a la db en firebase
    DocumentReference response = await db.collection(collection).add(user);
    notifyListeners();
    return response.id;
  }

  //metodo que recibe un string y lo compara con el password, si es igual retorna true
  Future<bool> login(String mail, String password) async {
    QuerySnapshot querySnapshot = await db
        .collection(collection)
        .where('mail', isEqualTo: mail)
        .where('password', isEqualTo: password)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}




  // Future<void> createWithId(Map<String, dynamic> user, String id) async {
  //   await db.collection(collection).doc(id).set(user);
  //   notifyListeners();
  // }

  // Future<void> remove(String id) async {
  //   await db.collection(collection).doc(id).delete();
  // }

  


// class UserProvider extends ChangeNotifier {
//   // Lista privada
//   List<User> _users = [];

// // Lista pública
//   List<User> get users => _users;

//   addUser(User user) {
//     _users.add(user);
//     notifyListeners();
//   }

//   void deleteUser(User user) {
//     _users.remove(user);
//     notifyListeners();
//   }
// }
