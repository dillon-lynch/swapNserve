// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  startDate: const TimestampConverter().fromJson(
    json['startDate'] as Timestamp,
  ),
  endDate: const TimestampConverter().fromJson(json['endDate'] as Timestamp),
  locationId: json['locationId'] as String,
  assignedUsers:
      (json['assignedUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  notes: json['notes'] as String? ?? '',
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
);

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'endDate': const TimestampConverter().toJson(instance.endDate),
      'locationId': instance.locationId,
      'assignedUsers': instance.assignedUsers,
      'notes': instance.notes,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
