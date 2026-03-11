import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swap_n_serve/models/converters/timestamp_converter.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType { intake, distributed }

@freezed
class Transaction with _$Transaction {
  const Transaction._();

  const factory Transaction({
    required String id,
    required String itemId,
    required TransactionType type,
    required int quantity,
    String? eventId,
    required String createdBy,
    @Default('') String notes,
    @TimestampConverter() required DateTime createdAt,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Transaction.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toMap() => toJson()..remove('id');
}
