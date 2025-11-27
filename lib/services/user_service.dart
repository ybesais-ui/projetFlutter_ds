import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Récupérer tous les utilisateurs
  Future<List<UserModel>> getAllUsers() async {
    QuerySnapshot snapshot = await _db.collection('users').get();

    return snapshot.docs.map((doc) {
      return UserModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();
  }

  // Récupérer un utilisateur spécifique par ID
  Future<UserModel?> getUserById(String id) async {
    DocumentSnapshot doc = await _db.collection('users').doc(id).get();

    if (!doc.exists) return null;

    return UserModel.fromMap(
      doc.data() as Map<String, dynamic>,
      doc.id,
    );
  }
}
