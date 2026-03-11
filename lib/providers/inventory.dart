import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'inventory.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<InventoryItem>> inventoryStream(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.inventoryItems)
      .orderBy('name')
      .snapshots()
      .map((snap) => snap.docs.map(InventoryItem.fromFirestore).toList());
}

@riverpod
Future<InventoryItem> inventoryItem(Ref ref, String itemId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc = await firestore
      .collection(FirestorePaths.inventoryItems)
      .doc(itemId)
      .get();
  return InventoryItem.fromFirestore(doc);
}

@riverpod
Stream<List<InventoryItem>> inventoryByCategory(Ref ref, String category) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.inventoryItems)
      .where('category', isEqualTo: category)
      .orderBy('name')
      .snapshots()
      .map((snap) => snap.docs.map(InventoryItem.fromFirestore).toList());
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
InventoryActions inventoryActions(Ref ref) {
  return InventoryActions(ref.watch(firestoreProvider));
}

class InventoryActions {
  final FirebaseFirestore _firestore;
  InventoryActions(this._firestore);

  CollectionReference get _ref =>
      _firestore.collection(FirestorePaths.inventoryItems);

  Future<String> create(InventoryItem item) async {
    final doc = await _ref.add(item.toMap());
    return doc.id;
  }

  Future<void> update(InventoryItem item) async {
    await _ref.doc(item.id).update(item.toMap());
  }

  Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}
