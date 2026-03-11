import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/providers/firebase.dart';
import 'package:swap_n_serve/repositories/inventory_repository.dart';

part 'inventory.g.dart';

@riverpod
InventoryRepository inventoryRepository(Ref ref) {
  return InventoryRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<InventoryItem>> inventoryStream(Ref ref) {
  return ref.watch(inventoryRepositoryProvider).watchAll();
}

@riverpod
Future<InventoryItem> inventoryItem(Ref ref, String itemId) {
  return ref.watch(inventoryRepositoryProvider).get(itemId);
}

@riverpod
Stream<List<InventoryItem>> inventoryByCategory(Ref ref, String category) {
  return ref.watch(inventoryRepositoryProvider).watchByCategory(category);
}
