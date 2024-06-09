import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class firebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance; //<===
  //#############INICIO SESION NATIVO###########################

  // Future<User?> signUpWithEmailAndPassword(
  //     String email, String password, String role) async {
  //   try {
  //     UserCredential credential = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);

  //     return credential.user;
  //   } catch (e) {
  //     print("Error en la autenticación: $e");
  //     return null;
  //   }
  // }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      // Agregar rol del usuario en Firestore
      await _firestore.collection('users').doc(user?.uid).set({
        'email': email,
        'role': role,
      });

      return user;
    } catch (e) {
      print("Error en la autenticación: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Error en la autenticación: $e");
      return null;
    }
  }

  //#################################################################################

  //###########INICIO SESION GOOGLE##############################################
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Verificar si el usuario ya está en Firestore, de lo contrario agregarlo con rol por defecto
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'email': userCredential.user?.email,
          'role': 'user', // Rol por defecto para usuarios nuevos
        });
      }

      // Print user information
      print("User information:");
      print("Display Name: ${userCredential.user?.displayName}");
      print("Email: ${userCredential.user?.email}");
      print("Photo URL: ${userCredential.user?.photoURL}");

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("El error es este manito $e");
      throw FirebaseAuthException(code: e.code);
    }
  }

  Future<String?> getUserRole() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      return userDoc['role'] as String?;
    }
    return null;
  }

  getCurrentUser() {
    return _auth.currentUser;
  }

  //#####################################################################################
}
