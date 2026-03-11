import 'package:cloud_firestore/cloud_firestore.dart';

enum StaffRole { admin, volunteer }

class Staff {
  final String id; // Firebase Auth UID
  final String name;
  final String email;
  final StaffRole role;
  final String avatarUrl;
  final DateTime createdAt;

  const Staff({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl = '',
    required this.createdAt,
  });

  factory Staff.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Staff(
      id: doc.id,
      name: data['name'] as String,
      email: data['email'] as String,
      role: StaffRole.values.byName(data['role'] as String),
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

  Staff copyWith({
    String? id,
    String? name,
    String? email,
    StaffRole? role,
    String? avatarUrl,
    DateTime? createdAt,
  }) {
    return Staff(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
