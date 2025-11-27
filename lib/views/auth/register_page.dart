import 'package:flutter/material.dart';
import 'package:projetflutter_ds/Controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Contrôleur d’authentification
  final AuthController _authController = AuthController();

  // Controllers des champs
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Pour afficher un loader

  // Nettoyage de la mémoire
  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fonction d'inscription
  Future<void> _register() async {
    setState(() => _isLoading = true);

    try {
      await _authController.register(
        _nomController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Si inscription réussie → message + retour
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Inscription réussie ✅")),
        );
        Navigator.pop(context); // Retour à la page précédente
      }
    } catch (e) {
      // Si erreur → afficher message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: $e")),
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créer un compte"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Champ nom
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(
                labelText: "Nom complet",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            // Champ email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 15),

            // Champ mot de passe
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 25),

            // Bouton s’inscrire ou loader
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton.icon(
                    onPressed: _register,
                    icon: const Icon(Icons.app_registration),
                    label: const Text("S'inscrire"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),

            const SizedBox(height: 15),

            // Lien retour login
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Retour à la connexion"),
            ),
          ],
        ),
      ),
    );
  }
}
