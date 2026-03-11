import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swap_n_serve/models/converters/timestamp_converter.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

enum UserRole { admin, volunteer }

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    @Default('') String avatarUrl,
    @TimestampConverter() required DateTime createdAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return AppUser.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toMap() => toJson()..remove('id');
}
