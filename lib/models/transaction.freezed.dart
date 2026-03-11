// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  String get itemId => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get eventId => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String get notes => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
    Transaction value,
    $Res Function(Transaction) then,
  ) = _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({
    String id,
    String itemId,
    TransactionType type,
    int quantity,
    String? eventId,
    String createdBy,
    String notes,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? type = null,
    Object? quantity = null,
    Object? eventId = freezed,
    Object? createdBy = null,
    Object? notes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            itemId: null == itemId
                ? _value.itemId
                : itemId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TransactionType,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            eventId: freezed == eventId
                ? _value.eventId
                : eventId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
    _$TransactionImpl value,
    $Res Function(_$TransactionImpl) then,
  ) = __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String itemId,
    TransactionType type,
    int quantity,
    String? eventId,
    String createdBy,
    String notes,
    @TimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
    _$TransactionImpl _value,
    $Res Function(_$TransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? itemId = null,
    Object? type = null,
    Object? quantity = null,
    Object? eventId = freezed,
    Object? createdBy = null,
    Object? notes = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$TransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        itemId: null == itemId
            ? _value.itemId
            : itemId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TransactionType,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        eventId: freezed == eventId
            ? _value.eventId
            : eventId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$TransactionImpl extends _Transaction {
  const _$TransactionImpl({
    required this.id,
    required this.itemId,
    required this.type,
    required this.quantity,
    this.eventId,
    required this.createdBy,
    this.notes = '',
    @TimestampConverter() required this.createdAt,
  }) : super._();

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String itemId;
  @override
  final TransactionType type;
  @override
  final int quantity;
  @override
  final String? eventId;
  @override
  final String createdBy;
  @override
  @JsonKey()
  final String notes;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'Transaction(id: $id, itemId: $itemId, type: $type, quantity: $quantity, eventId: $eventId, createdBy: $createdBy, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    itemId,
    type,
    quantity,
    eventId,
    createdBy,
    notes,
    createdAt,
  );

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(this);
  }
}

abstract class _Transaction extends Transaction {
  const factory _Transaction({
    required final String id,
    required final String itemId,
    required final TransactionType type,
    required final int quantity,
    final String? eventId,
    required final String createdBy,
    final String notes,
    @TimestampConverter() required final DateTime createdAt,
  }) = _$TransactionImpl;
  const _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get itemId;
  @override
  TransactionType get type;
  @override
  int get quantity;
  @override
  String? get eventId;
  @override
  String get createdBy;
  @override
  String get notes;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
