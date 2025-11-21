import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ------------------------------
  // Récupérer un utilisateur par son ID
  // ------------------------------
  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection("users").doc(uid).get();

    if (!doc.exists) return null; // Si l'utilisateur n'existe pas

    return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ------------------------------
  // Récupérer la liste de tous les utilisateurs
  // ------------------------------
  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot query = await _db.collection("users").get();

    // Transformer chaque document Firestore en objet UserModel
    return query.docs
        .map((d) => UserModel.fromMap(d.data() as Map<String, dynamic>, d.id))
        .toList();
  }

  // ------------------------------
  // Mettre à jour les informations d'un utilisateur
  // ------------------------------
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}
