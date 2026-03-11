import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { admin, volunteer }

class AppUser {
  final String id; // Firebase Auth UID
  final String name;
  final String email;
  final UserRole role;
  final String avatarUrl;
  final DateTime createdAt;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl = '',
    required this.createdAt,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return AppUser(
      id: doc.id,
      name: data['name'] as String,
      email: data['email'] as String,
      role: UserRole.values.byName(data['role'] as String),
      avatarUrl: data['avatarUrl'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'role': role.name,
        'avatarUrl': avatarUrl,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? avatarUrl,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
