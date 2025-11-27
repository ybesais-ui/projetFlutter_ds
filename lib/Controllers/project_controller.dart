import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';

class ProjectController {
  final ProjectService _service = ProjectService();

  List<ProjectModel> projects = [];
  bool isLoading = false;

  /// Charger tous les projets depuis Firestore (via le service)
  Future<void> loadProjects() async {
    isLoading = true;
    try {
      projects = await _service.getAllProjects();
    } catch (e) {
      debugPrint('Erreur loadProjects: $e');
      projects = [];
    } finally {
      isLoading = false;
    }
  }

  /// Ajouter un projet (passe par le service) puis recharger la liste
  Future<void> addProject(ProjectModel project) async {
    try {
      await _service.addProject(project);
      await loadProjects();
    } catch (e) {
      debugPrint('Erreur addProject: $e');
      rethrow;
    }
  }

  /// Supprimer un projet puis recharger la liste
  Future<void> deleteProject(String id) async {
    try {
      await _service.deleteProject(id);
      await loadProjects();
    } catch (e) {
      debugPrint('Erreur deleteProject: $e');
      rethrow;
    }
  }

  /// Récupérer un projet déjà chargé (depuis la liste en mémoire)
  ProjectModel? getById(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// ✅ Récupérer un seul projet depuis Firestore par son ID
  ///    (utilisé par ProjectDetailPage si tu veux charger uniquement ce doc)
  Future<ProjectModel?> fetchProjectById(String id) async {
    try {
      final project = await _service.fetchProject(id);
      return project;
    } catch (e) {
      debugPrint('Erreur fetchProjectById: $e');
      return null;
    }
  }
}
