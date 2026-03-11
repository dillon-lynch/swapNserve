import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String locationId;
  final List<String> assignedUsers;
  final String notes;
  final DateTime createdAt;

  const Event({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.locationId,
    required this.assignedUsers,
    this.notes = '',
    required this.createdAt,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'] as String,
      startDate: (data['startDate'] as Timestamp).toDate(),
      endDate: (data['endDate'] as Timestamp).toDate(),
      locationId: data['locationId'] as String,
      assignedUsers: List<String>.from(data['assignedUsers'] ?? []),
      notes: data['notes'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'startDate': Timestamp.fromDate(startDate),
    'endDate': Timestamp.fromDate(endDate),
    'locationId': locationId,
    'assignedUsers': assignedUsers,
    'notes': notes,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Event copyWith({
    String? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? locationId,
    List<String>? assignedUsers,
    String? notes,
    DateTime? createdAt,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      locationId: locationId ?? this.locationId,
      assignedUsers: assignedUsers ?? this.assignedUsers,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
