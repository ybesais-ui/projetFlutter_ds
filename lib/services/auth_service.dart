import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //auth
  Future<User?> login(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      print("Erreur login: $e");
      rethrow;
    }
  }

  // cration compte
  Future<User?> register(String email, String password, String nom) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //  Firestore
      await _db.collection("users").doc(cred.user!.uid).set({
        "nom": nom,
        "email": email,
        "role": "membre",
      });

      return cred.user;
    } catch (e) {
      print("Erreur register: $e");
      rethrow;
    }
  }

  //logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  
  User? get currentUser => _auth.currentUser;
}
