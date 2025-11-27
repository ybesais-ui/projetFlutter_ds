import 'package:flutter/material.dart';
import '../../models/project_model.dart';
import '../../controllers/project_controller.dart';

/// Page qui affiche les détails d’un projet spécifique
class ProjectDetailPage extends StatefulWidget {
  final String projectId; // ID du projet à afficher

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  final ProjectController _controller = ProjectController();
  ProjectModel? _project;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initAndFetch();
  }

  /// Initialiser puis charger le projet
  Future<void> _initAndFetch() async {
    await _controller.loadProjects(); // Charger la liste (optionnel mais utile si besoin plus tard)
    final data = await _controller.fetchProjectById(widget.projectId);
    
    setState(() {
      _project = data;
      _isLoading = false;
    });

    if (_project == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Projet non trouvé")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du projet"),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _project == null
              ? const Center(child: Text("Aucune donnée à afficher"))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _project!.nom,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text("📝 Description : ${_project!.description}"),
                      const SizedBox(height: 8),

                      Text("⏳ Deadline : ${_project!.deadline.toLocal().toString().split(' ')[0]}"),
                      const SizedBox(height: 8),

                      Text("👤 Créateur ID : ${_project!.creePar}"),
                      const SizedBox(height: 8),

                      Text("👥 Membres IDs : ${_project!.membresIds.join(', ')}"),
                    ],
                  ),
                ),
    );
  }
}
