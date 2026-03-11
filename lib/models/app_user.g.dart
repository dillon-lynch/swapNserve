// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      avatarUrl: json['avatarUrl'] as String? ?? '',
      createdAt: const TimestampConverter().fromJson(
        json['createdAt'] as Timestamp,
      ),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': _$UserRoleEnumMap[instance.role]!,
      'avatarUrl': instance.avatarUrl,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.volunteer: 'volunteer',
};
