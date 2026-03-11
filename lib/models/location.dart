import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swap_n_serve/models/converters/timestamp_converter.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  const Location._();

  const factory Location({
    required String id,
    required String name,
    required String address,
    required double lat,
    required double lng,
    @TimestampConverter() required DateTime createdAt,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  factory Location.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Location.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toMap() => toJson()..remove('id');
}
