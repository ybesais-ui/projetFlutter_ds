import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Connexion utilisateur
  Future<UserModel> login(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = result.user!.uid;

    // Récupérer les informations utilisateur depuis Firestore
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();

    return UserModel.fromMap(doc.data() as Map<String, dynamic>, uid);
  }

  // Inscription utilisateur
  Future<UserModel> register(String nom, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = result.user!.uid;

    UserModel user = UserModel(
      id: uid,
      nom: nom,
      email: email,
      role: "membre",
    );

    await _db.collection('users').doc(uid).set(user.toMap());

    return user;
  }

  // Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
  }
}
