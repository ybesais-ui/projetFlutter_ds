import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class ProjectService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Récupérer tous les projets
  Future<List<ProjectModel>> getAllProjects() async {
    final snapshot = await _db.collection('projects').get();
    return snapshot.docs
        .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  /// Ajouter un projet
  Future<void> addProject(ProjectModel project) async {
    await _db.collection('projects').doc(project.id).set(project.toMap());
  }

  /// Supprimer un projet
  Future<void> deleteProject(String id) async {
    await _db.collection('projects').doc(id).delete();
  }

  ///  Récupérer un seul projet par ID
  Future<ProjectModel?> fetchProject(String id) async {
    final doc = await _db.collection('projects').doc(id).get();
    if (!doc.exists) return null;
    return ProjectModel.fromMap(doc.data()!, doc.id);
  }
}
