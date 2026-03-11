// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      senderId: json['senderId'] as String,
      message: json['message'] as String,
      timestamp: const TimestampConverter().fromJson(
        json['timestamp'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'senderId': instance.senderId,
      'message': instance.message,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
