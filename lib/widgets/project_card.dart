import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../views/project/project_detail_page.dart';

/// Widget représentant une carte visuelle pour afficher un projet dans une liste.
/// Il permet aussi la navigation vers la page de détails et la suppression du projet.
class ProjectCard extends StatelessWidget {
  final ProjectModel project; // L’objet contenant toutes les informations du projet.

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Ombre sous la carte pour donner un effet flottant.
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6), // Espacement autour de la carte.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Coins arrondis pour un design moderne.
      ),
      child: Padding(
        padding: const EdgeInsets.all(14), // Padding interne de la carte.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Contenu aligné à gauche.
          children: [
            // ---------------- Nom du projet ----------------
            Text(
              project.nom,
              style: const TextStyle(
                fontSize: 17, // Taille du texte du titre.
                fontWeight: FontWeight.bold, // Mettre en gras.
              ),
            ),
            const SizedBox(height: 6), // Espacement vertical.

            // ---------------- Description du projet ----------------
            Text(
              project.description,
              style: const TextStyle(fontSize: 14), // Style normal pour la description.
              maxLines: 2, // Limiter à 2 lignes.
              overflow: TextOverflow.ellipsis, // Ajouter "..." si trop long.
            ),
            const SizedBox(height: 10),

            // ---------------- Affichage du deadline (date limite) ----------------
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 15), // Icône calendrier.
                const SizedBox(width: 5),
                Text(
                  "Deadline: ${project.deadline.toLocal().toString().split(' ')[0]}", 
                  // On prend seulement la partie date, sans l’heure.
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 5),

            // ---------------- Affichage du créateur du projet ----------------
            Row(
              children: [
                const Icon(Icons.person, size: 15), // Icône utilisateur.
                const SizedBox(width: 5),
                Text(
                  "Créé par: ${project.creePar}", // ID/email/nom de l'utilisateur qui a créé.
                  style: const TextStyle(fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ---------------- Liste des membres affectés (affichés sous forme de Chips) ----------------
            Wrap(
              spacing: 6, // Espacement horizontal entre les chips.
              children: project.membresIds.map((idMembre) {
                return Chip(
                  label: Text(
                    idMembre,
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // ---------------- Boutons d’action : voir + supprimer ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // On place les boutons à droite.
              children: [
                // Bouton "Voir" → navigation vers la page de détails du projet.
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailPage(projectId: project.id),
                      ),
                    );
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text("Voir"),
                ),
                const SizedBox(width: 8),

                // Bouton "Supprimer" → suppression du projet dans Firestore.
                TextButton.icon(
                  onPressed: () async {
                    // Si tu as un controller global, appelle : controller.deleteProject(project.id)
                    // Ici on met juste une alerte visuelle pour exemple.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Action supprimer à implémenter dans Controller")),
                    );
                  },
                  icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                  label: const Text(
                    "Supprimer",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
