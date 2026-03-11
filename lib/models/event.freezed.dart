// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get endDate => throw _privateConstructorUsedError;
  String get locationId => throw _privateConstructorUsedError;
  List<String> get assignedUsers => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call({
    String id,
    String title,
    @TimestampConverter() DateTime startDate,
    @TimestampConverter() DateTime endDate,
    String locationId,
    List<String> assignedUsers,
    String notes,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationId = null,
    Object? assignedUsers = null,
    Object? notes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            locationId: null == locationId
                ? _value.locationId
                : locationId // ignore: cast_nullable_to_non_nullable
                      as String,
            assignedUsers: null == assignedUsers
                ? _value.assignedUsers
                : assignedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            notes: null == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
    _$EventImpl value,
    $Res Function(_$EventImpl) then,
  ) = __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    @TimestampConverter() DateTime startDate,
    @TimestampConverter() DateTime endDate,
    String locationId,
    List<String> assignedUsers,
    String notes,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
    _$EventImpl _value,
    $Res Function(_$EventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? locationId = null,
    Object? assignedUsers = null,
    Object? notes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$EventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                  as String,
        assignedUsers: null == assignedUsers
            ? _value._assignedUsers
            : assignedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        notes: null == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl extends _Event {
  const _$EventImpl({
    required this.id,
    required this.title,
    @TimestampConverter() required this.startDate,
    @TimestampConverter() required this.endDate,
    required this.locationId,
    final List<String> assignedUsers = const [],
    this.notes = '',
    @TimestampConverter() required this.createdAt,
  }) : _assignedUsers = assignedUsers,
       super._();

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @TimestampConverter()
  final DateTime startDate;
  @override
  @TimestampConverter()
  final DateTime endDate;
  @override
  final String locationId;
  final List<String> _assignedUsers;
  @override
  @JsonKey()
  List<String> get assignedUsers {
    if (_assignedUsers is EqualUnmodifiableListView) return _assignedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedUsers);
  }

  @override
  @JsonKey()
  final String notes;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Event(id: $id, title: $title, startDate: $startDate, endDate: $endDate, locationId: $locationId, assignedUsers: $assignedUsers, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            const DeepCollectionEquality().equals(
              other._assignedUsers,
              _assignedUsers,
            ) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    startDate,
    endDate,
    locationId,
    const DeepCollectionEquality().hash(_assignedUsers),
    notes,
    createdAt,
  );

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(this);
  }
}

abstract class _Event extends Event {
  const factory _Event({
    required final String id,
    required final String title,
    @TimestampConverter() required final DateTime startDate,
    @TimestampConverter() required final DateTime endDate,
    required final String locationId,
    final List<String> assignedUsers,
    final String notes,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$EventImpl;
  const _Event._() : super._();

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @TimestampConverter()
  DateTime get startDate;
  @override
  @TimestampConverter()
  DateTime get endDate;
  @override
  String get locationId;
  @override
  List<String> get assignedUsers;
  @override
  String get notes;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
