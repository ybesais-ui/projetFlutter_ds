import 'package:flutter/material.dart';

/// Widget qui affiche un avatar utilisateur réutilisable dans l’application.
/// Il permet d’afficher soit :
///  - la première lettre du nom de l’utilisateur dans un cercle coloré,
///  - ou une image profil si on fournit l’URL.
/// Il prend aussi un rôle pour afficher une indication optionnelle.
class UserAvatar extends StatelessWidget {
  final String nom;        // Nom de l’utilisateur (ex: "Yasmine")
  final String? imageUrl;  // URL de l’image du profil (optionnel)
  final String? role;      // Rôle de l’utilisateur (optionnel, ex: "admin", "membre")

  const UserAvatar({
    super.key,
    required this.nom,
    this.imageUrl,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    // Prendre la première lettre du nom si aucune image n'est fournie.
    String initial = nom.isNotEmpty ? nom[0].toUpperCase() : "?";

    return Column(
      mainAxisSize: MainAxisSize.min, // Adapter la taille au contenu
      children: [
        /// ---------------- Avatar circulaire ----------------
        CircleAvatar(
          radius: 22, // Taille du cercle de l’avatar
          backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
              ? NetworkImage(imageUrl!) // Afficher l’image si disponible
              : null,
          child: imageUrl == null || imageUrl!.isEmpty
              ? Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),

        if (role != null) ...[
          const SizedBox(height: 4),

          /// ---------------- Affichage du rôle ----------------
          Text(
            role!.toLowerCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ]
      ],
    );
  }
}
