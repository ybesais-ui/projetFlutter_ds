class TaskModel {
  final String id;
  final String titre;
  final String description;
  final String statut; // "à faire", "en cours", "terminée"
  final String projetId;
  final String creePar;

  TaskModel({
    required this.id,
    required this.titre,
    required this.description,
    required this.statut,
    required this.projetId,
    required this.creePar,
  });

  factory TaskModel.fromMap(Map<String, dynamic> data, String id) {
    return TaskModel(
      id: id,
      titre: data['titre'] ?? '',
      description: data['description'] ?? '',
      statut: data['statut'] ?? 'à faire',
      projetId: data['projet_id'] ?? '',
      creePar: data['cree_par'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'description': description,
      'statut': statut,
      'projet_id': projetId,
      'cree_par': creePar,
    };
  }
}
