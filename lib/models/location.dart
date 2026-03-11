import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final DateTime createdAt;

  const Location({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.createdAt,
  });

  factory Location.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Location(
      id: doc.id,
      name: data['name'] as String,
      address: data['address'] as String,
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'address': address,
    'lat': lat,
    'lng': lng,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Location copyWith({
    String? id,
    String? name,
    String? address,
    double? lat,
    double? lng,
    DateTime? createdAt,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
