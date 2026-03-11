import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swap_n_serve/models/converters/timestamp_converter.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const Event._();

  const factory Event({
    required String id,
    required String title,
    @TimestampConverter() required DateTime startDate,
    @TimestampConverter() required DateTime endDate,
    required String locationId,
    @Default([]) List<String> assignedUsers,
    @Default('') String notes,
    @TimestampConverter() required DateTime createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Event.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toMap() => toJson()..remove('id');
}
