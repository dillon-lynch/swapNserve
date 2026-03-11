// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryItemImpl _$$InventoryItemImplFromJson(Map<String, dynamic> json) =>
    _$InventoryItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
      totalStock: (json['totalStock'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$InventoryItemImplToJson(_$InventoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'totalStock': instance.totalStock,
    };
