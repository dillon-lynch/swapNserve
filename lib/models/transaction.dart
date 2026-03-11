import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;

enum TransactionType { intake, distributed }

class Transaction {
  final String id;
  final String itemId;
  final TransactionType type;
  final int quantity;
  final String? eventId; // null = outside an event
  final String createdBy; // user UID
  final String notes;
  final DateTime createdAt;

  const Transaction({
    required this.id,
    required this.itemId,
    required this.type,
    required this.quantity,
    this.eventId,
    required this.createdBy,
    this.notes = '',
    required this.createdAt,
  });

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Transaction(
      id: doc.id,
      itemId: data['itemId'] as String,
      type: TransactionType.values.byName(data['type'] as String),
      quantity: data['quantity'] as int,
      eventId: data['eventId'] as String?,
      createdBy: data['createdBy'] as String,
      notes: data['notes'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'itemId': itemId,
    'type': type.name,
    'quantity': quantity,
    'eventId': eventId,
    'createdBy': createdBy,
    'notes': notes,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Transaction copyWith({
    String? id,
    String? itemId,
    TransactionType? type,
    int? quantity,
    String? eventId,
    String? createdBy,
    String? notes,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      eventId: eventId ?? this.eventId,
      createdBy: createdBy ?? this.createdBy,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
