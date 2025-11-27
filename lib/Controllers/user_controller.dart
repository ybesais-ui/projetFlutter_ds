import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';

class UserController with ChangeNotifier {
  final UserService _service = UserService();

  List<UserModel> users = [];
  bool isLoading = false;

  // Charger tous les utilisateurs
  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    users = await _service.getAllUsers();

    isLoading = false;
    notifyListeners();
  }

  // Récupérer un utilisateur par ID
  Future<UserModel?> getUserById(String id) async {
    return await _service.getUserById(id);
  }
}
