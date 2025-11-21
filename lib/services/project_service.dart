import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class ProjectService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ------------------------------
  // Ajouter un nouveau projet
  // ------------------------------
  Future<void> addProject(ProjectModel project) async {
    await _db.collection("projects").add(project.toMap());
  }

  // ------------------------------
  // Récupérer tous les projets
  // ------------------------------
  Future<List<ProjectModel>> getProjects() async {
    QuerySnapshot query = await _db.collection("projects").get();

    return query.docs
        .map((doc) => ProjectModel.fromMap(
            doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  // ------------------------------
  // Récupérer un projet par ID
  // ------------------------------
  Future<ProjectModel?> getProject(String id) async {
    DocumentSnapshot doc = await _db.collection("projects").doc(id).get();

    if (!doc.exists) return null;

    return ProjectModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  // ------------------------------
  // Mettre à jour un projet
  // ------------------------------
  Future<void> updateProject(String id, Map<String, dynamic> data) async {
    await _db.collection("projects").doc(id).update(data);
  }

  // ------------------------------
  // Supprimer un projet
  // ------------------------------
  Future<void> deleteProject(String id) async {
    await _db.collection("projects").doc(id).delete();
  }
}
