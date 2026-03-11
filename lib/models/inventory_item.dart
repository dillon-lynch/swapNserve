import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swap_n_serve/models/converters/timestamp_converter.dart';

part 'inventory_item.freezed.dart';
part 'inventory_item.g.dart';

@freezed
class InventoryItem with _$InventoryItem {
  const InventoryItem._();

  const factory InventoryItem({
    required String id,
    required String name,
    required String category,
    @Default('') String description,
    @Default('') String imageUrl,
    @TimestampConverter() required DateTime createdAt,
    /// Derived from transactions, not stored in Firestore.
    @Default(0) int totalStock,
  }) = _InventoryItem;

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return InventoryItem.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toMap() =>
      toJson()..remove('id')..remove('totalStock');
}
