import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? currentUser;
  bool isLoading = false;

  // Connexion utilisateur
  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      currentUser = await _authService.login(email, password);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Inscription utilisateur
  Future<bool> register(String nom, String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      currentUser = await _authService.register(nom, email, password);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _authService.logout();
    currentUser = null;
    notifyListeners();
  }
}
