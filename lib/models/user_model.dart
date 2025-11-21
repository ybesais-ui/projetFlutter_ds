class UserModel {
  final String id;
  final String nom;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.nom,
    required this.email,
    required this.role,
  });

  // تحويل من Firestore → Object
  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? 'membre',
    );
  }

  // تحويل من Object → Firestore
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
      'role': role,
    };
  }
}
