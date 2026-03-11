// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      itemId: json['itemId'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      quantity: (json['quantity'] as num).toInt(),
      eventId: json['eventId'] as String?,
      createdBy: json['createdBy'] as String,
      notes: json['notes'] as String? ?? '',
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'itemId': instance.itemId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'quantity': instance.quantity,
      'eventId': instance.eventId,
      'createdBy': instance.createdBy,
      'notes': instance.notes,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.intake: 'intake',
  TransactionType.distributed: 'distributed',
};
