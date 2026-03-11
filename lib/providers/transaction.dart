import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/transaction.dart';
import 'package:swap_n_serve/providers/inventory.dart';

part 'transaction.g.dart';

@riverpod
Stream<List<Transaction>> itemTransactions(Ref ref, String itemId) {
  return ref.watch(inventoryRepositoryProvider).watchTransactionsForItem(itemId);
}

@riverpod
Stream<List<Transaction>> eventTransactions(Ref ref, String eventId) {
  return ref.watch(inventoryRepositoryProvider).watchTransactionsForEvent(eventId);
}

@riverpod
Future<int> itemStock(Ref ref, String itemId) {
  return ref.watch(inventoryRepositoryProvider).getStockForItem(itemId);
}

@riverpod
Future<int> eventDistributionTotal(Ref ref, String eventId) {
  return ref.watch(inventoryRepositoryProvider).getEventDistributionTotal(eventId);
}
