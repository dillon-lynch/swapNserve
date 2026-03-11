import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/inventory.dart';
import 'package:swap_n_serve/providers/transaction.dart';

class InventoryItemDetailScreen extends ConsumerWidget {
  final String itemId;

  const InventoryItemDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(inventoryItemProvider(itemId));
    final stockAsync = ref.watch(itemStockProvider(itemId));
    final txnsAsync = ref.watch(itemTransactionsProvider(itemId));

    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: itemAsync.when(
        data: (item) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                item.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                item.category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              stockAsync.when(
                data: (stock) => Chip(label: Text('Stock: $stock')),
                loading: () => const Chip(label: Text('Stock: ...')),
                error: (e, _) => Chip(label: Text('Error: $e')),
              ),
              const Divider(height: 32),
              Text(
                'Transaction History',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              txnsAsync.when(
                data: (txns) => Column(
                  children: txns
                      .map(
                        (t) => ListTile(
                          leading: Icon(
                            t.type.name == 'intake'
                                ? Icons.add_circle
                                : Icons.remove_circle,
                            color: t.type.name == 'intake'
                                ? Colors.green
                                : Colors.red,
                          ),
                          title: Text(
                            '${t.type.name.toUpperCase()} × ${t.quantity}',
                          ),
                          subtitle: Text(t.createdAt.toLocal().toString()),
                        ),
                      )
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
