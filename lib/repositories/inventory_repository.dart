import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/models/transaction.dart';

class InventoryRepository {
  final FirebaseFirestore _firestore;

  InventoryRepository(this._firestore);

  CollectionReference get _itemsRef =>
      _firestore.collection(FirestorePaths.inventoryItems);

  CollectionReference get _txnRef =>
      _firestore.collection(FirestorePaths.inventoryTransactions);

  // ---------------------------------------------------------------------------
  // Inventory items
  // ---------------------------------------------------------------------------

  Stream<List<InventoryItem>> watchAll() {
    return _itemsRef
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map(InventoryItem.fromFirestore).toList());
  }

  Future<InventoryItem> get(String itemId) async {
    final doc = await _itemsRef.doc(itemId).get();
    return InventoryItem.fromFirestore(doc);
  }

  Stream<List<InventoryItem>> watchByCategory(String category) {
    return _itemsRef
        .where('category', isEqualTo: category)
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map(InventoryItem.fromFirestore).toList());
  }

  Future<String> createItem(InventoryItem item) async {
    final doc = await _itemsRef.add(item.toMap());
    return doc.id;
  }

  Future<void> updateItem(InventoryItem item) async {
    await _itemsRef.doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _itemsRef.doc(id).delete();
  }

  // ---------------------------------------------------------------------------
  // Transactions
  // ---------------------------------------------------------------------------

  Stream<List<Transaction>> watchTransactionsForItem(String itemId) {
    return _txnRef
        .where('itemId', isEqualTo: itemId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Transaction.fromFirestore).toList());
  }

  Stream<List<Transaction>> watchTransactionsForEvent(String eventId) {
    return _txnRef
        .where('eventId', isEqualTo: eventId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Transaction.fromFirestore).toList());
  }

  Future<int> getStockForItem(String itemId) async {
    final snap =
        await _txnRef.where('itemId', isEqualTo: itemId).get();
    final txns = snap.docs.map(Transaction.fromFirestore);
    int stock = 0;
    for (final txn in txns) {
      stock +=
          txn.type == TransactionType.intake ? txn.quantity : -txn.quantity;
    }
    return stock;
  }

  Future<int> getEventDistributionTotal(String eventId) async {
    final snap = await _txnRef
        .where('eventId', isEqualTo: eventId)
        .where('type', isEqualTo: TransactionType.distributed.name)
        .get();
    final txns = snap.docs.map(Transaction.fromFirestore);
    return txns.fold<int>(0, (sum, txn) => sum + txn.quantity);
  }

  Future<void> addTransaction(Transaction txn) async {
    await _txnRef.add(txn.toMap());
  }
}
