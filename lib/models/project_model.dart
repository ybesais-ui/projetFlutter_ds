import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String nom;
  final String description;
  final DateTime deadline;
  final List<String> membresIds;
  final String creePar;

  ProjectModel({
    required this.id,
    required this.nom,
    required this.description,
    required this.deadline,
    required this.membresIds,
    required this.creePar,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> data, String id) {
    return ProjectModel(
      id: id,
      nom: data['nom'] ?? '',
      description: data['description'] ?? '',
      deadline: (data['deadline'] as Timestamp).toDate(),
      membresIds: List<String>.from(data['membres_ids'] ?? []),
      creePar: data['cree_par'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'description': description,
      'deadline': deadline,
      'membres_ids': membresIds,
      'cree_par': creePar,
    };
  }
}
