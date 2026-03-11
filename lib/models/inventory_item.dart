import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  /// totalStock is NOT stored in Firestore.
  /// It is derived from transactions: SUM(intake) - SUM(distributed).
  /// This field is populated by the provider layer after querying transactions.
  final int totalStock;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    this.description = '',
    this.imageUrl = '',
    required this.createdAt,
    this.totalStock = 0,
  });

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      name: data['name'] as String,
      category: data['category'] as String,
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'description': description,
    'imageUrl': imageUrl,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  InventoryItem copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    int? totalStock,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      totalStock: totalStock ?? this.totalStock,
    );
  }
}
