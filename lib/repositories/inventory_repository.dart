import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/models/transaction.dart';

/// Holds aggregated stock for a single category.
class CategoryStock {
  final String category;
  int total;
  final Map<String, int> perItem; // itemId -> stock

  CategoryStock({
    required this.category,
    this.total = 0,
    Map<String, int>? perItem,
  }) : perItem = perItem ?? {};
}

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

  /// Computes stock for every item that belongs to [category].
  /// Returns a map of { itemId: stockCount } and a total.
  Future<CategoryStock> getStockForCategory(String category) async {
    // 1. Get all items in this category
    final itemSnap =
        await _itemsRef.where('category', isEqualTo: category).get();
    final itemIds =
        itemSnap.docs.map((d) => d.id).toSet();
    if (itemIds.isEmpty) return CategoryStock(category: category);

    // 2. Fetch all transactions for those items (single query per category)
    //    Firestore whereIn supports up to 30 values – chunk if needed.
    int total = 0;
    final perItem = <String, int>{};
    for (var i = 0; i < itemIds.length; i += 30) {
      final chunk = itemIds.skip(i).take(30).toList();
      final txnSnap =
          await _txnRef.where('itemId', whereIn: chunk).get();
      for (final doc in txnSnap.docs) {
        final txn = Transaction.fromFirestore(doc);
        final delta = txn.type == TransactionType.intake
            ? txn.quantity
            : -txn.quantity;
        perItem[txn.itemId] = (perItem[txn.itemId] ?? 0) + delta;
        total += delta;
      }
    }
    return CategoryStock(
      category: category,
      total: total,
      perItem: perItem,
    );
  }

  /// Computes stock for ALL categories in a single pass.
  Future<Map<String, CategoryStock>> getStockForAllCategories() async {
    // One full scan of transactions + one full scan of items.
    final itemSnap = await _itemsRef.get();
    final categoryOf = <String, String>{}; // itemId -> category
    for (final doc in itemSnap.docs) {
      final data = doc.data()! as Map<String, dynamic>;
      categoryOf[doc.id] = data['category'] as String? ?? '';
    }

    final txnSnap = await _txnRef.get();
    final result = <String, CategoryStock>{};
    for (final doc in txnSnap.docs) {
      final txn = Transaction.fromFirestore(doc);
      final cat = categoryOf[txn.itemId];
      if (cat == null) continue;
      final delta = txn.type == TransactionType.intake
          ? txn.quantity
          : -txn.quantity;
      final cs = result.putIfAbsent(
          cat, () => CategoryStock(category: cat));
      cs.perItem[txn.itemId] = (cs.perItem[txn.itemId] ?? 0) + delta;
      cs.total += delta;
    }
    // Ensure categories with zero transactions appear too.
    for (final cat in categoryOf.values.toSet()) {
      result.putIfAbsent(cat, () => CategoryStock(category: cat));
    }
    return result;
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
