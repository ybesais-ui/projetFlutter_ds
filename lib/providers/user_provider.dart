import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Données de l'utilisateur récupérées depuis Firestore
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  //  Récupération des informations d’un utilisateur
  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _db.collection('users').doc(uid).get();

      if (snapshot.exists) {
        _userData = snapshot.data() as Map<String, dynamic>;
      }

      notifyListeners(); // Mise à jour interface

    } catch (e) {
      print("Erreur fetchUserData: $e");
    }
  }

  //  Mise à jour des informations d’un utilisateur
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(uid).update(data);

      // Recharger les nouvelles données
      await fetchUserData(uid);

    } catch (e) {
      print("Erreur updateUserData: $e");
    }
  }
}
