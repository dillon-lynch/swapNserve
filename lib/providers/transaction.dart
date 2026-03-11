import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/transaction.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'transaction.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<Transaction>> itemTransactions(Ref ref, String itemId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.inventoryTransactions)
      .where('itemId', isEqualTo: itemId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(Transaction.fromFirestore).toList());
}

@riverpod
Stream<List<Transaction>> eventTransactions(Ref ref, String eventId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.inventoryTransactions)
      .where('eventId', isEqualTo: eventId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(Transaction.fromFirestore).toList());
}

/// Derives current stock for an item: SUM(intake) - SUM(distributed).
@riverpod
Future<int> itemStock(Ref ref, String itemId) async {
  final firestore = ref.watch(firestoreProvider);
  final snap = await firestore
      .collection(FirestorePaths.inventoryTransactions)
      .where('itemId', isEqualTo: itemId)
      .get();
  final txns = snap.docs.map(Transaction.fromFirestore);

  int stock = 0;
  for (final txn in txns) {
    stock += txn.type == TransactionType.intake ? txn.quantity : -txn.quantity;
  }
  return stock;
}

/// Total items distributed during a specific event.
@riverpod
Future<int> eventDistributionTotal(Ref ref, String eventId) async {
  final firestore = ref.watch(firestoreProvider);
  final snap = await firestore
      .collection(FirestorePaths.inventoryTransactions)
      .where('eventId', isEqualTo: eventId)
      .where('type', isEqualTo: TransactionType.distributed.name)
      .get();
  final txns = snap.docs.map(Transaction.fromFirestore);
  return txns.fold<int>(0, (sum, txn) => sum + txn.quantity);
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
TransactionActions transactionActions(Ref ref) {
  return TransactionActions(ref.watch(firestoreProvider));
}

class TransactionActions {
  final FirebaseFirestore _firestore;
  TransactionActions(this._firestore);

  CollectionReference get _ref =>
      _firestore.collection(FirestorePaths.inventoryTransactions);

  Future<void> create(Transaction txn) async {
    await _ref.add(txn.toMap());
  }
}
