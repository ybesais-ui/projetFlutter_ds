import 'package:flutter/material.dart';
import '../../controllers/project_controller.dart';
import '../../models/project_model.dart';
import '../project/project_detail_page.dart';

/// Page qui affiche tous les projets sous forme de liste
class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  // ✅ Utiliser le controller sans ChangeNotifier
  final ProjectController _controller = ProjectController();
  
  bool _isLoading = true; // État de chargement

  @override
  void initState() {
    super.initState();
    _loadProjects(); // Charger les projets au démarrage
  }

  /// Fonction qui charge les projets depuis Firestore
  Future<void> _loadProjects() async {
    try {
      await _controller.loadProjects();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur Firestore : $e")),
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des projets"), // Titre
        centerTitle: true, // Centrer
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Loader affiché si chargement
          : _controller.projects.isEmpty
              ? const Center(child: Text("Aucun projet disponible")) // Si aucun projet
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _controller.projects.length,
                  itemBuilder: (context, index) {
                    final project = _controller.projects[index];

                    return Card(
                      child: ListTile(
                        title: Text(project.nom), // Nom du projet
                        subtitle: Text(project.description), // Description
                        
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await _controller.deleteProject(project.id);
                            setState(() {}); // Actualiser l’UI
                          },
                        ),

                        // ✅ Navigation vers la page détails
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProjectDetailPage(projectId: project.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
