import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/transaction.dart';
import 'package:swap_n_serve/providers/inventory.dart';
import 'package:swap_n_serve/providers/transaction.dart';
import 'package:swap_n_serve/repositories/inventory_repository.dart';

class InventoryItemDetailScreen extends ConsumerWidget {
  final String itemId;

  const InventoryItemDetailScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(inventoryItemProvider(itemId));
    final txnsAsync = ref.watch(itemTransactionsProvider(itemId));
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: itemAsync.when(
        data: (item) {
          final catStockAsync =
              ref.watch(categoryStockProvider(item.category));

          return CustomScrollView(
          slivers: [
            // Hero image app bar
            SliverAppBar.large(
              expandedHeight: 280,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                background: item.imageUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black26,
                        colorBlendMode: BlendMode.darken,
                      )
                    : Container(
                        color: colors.surfaceContainerHighest,
                        child: Center(
                          child: Icon(
                            Icons.inventory_2_outlined,
                            size: 80,
                            color: colors.outline,
                          ),
                        ),
                      ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category + stock row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colors.secondaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.category,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: colors.onSecondaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        catStockAsync.when(
                          data: (cs) => _StockIndicator(
                              stock: cs.total,
                              label: '${item.category} stock',
                              colors: colors),
                          loading: () => const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          ),
                          error: (e, _) => Text('Error: $e'),
                        ),
                      ],
                    ),

                    if (item.description.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        item.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Quick action buttons
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => _showTransactionDialog(
                              context,
                              ref,
                              TransactionType.intake,
                            ),
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('Add Intake'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.tonalIcon(
                            onPressed: () => _showTransactionDialog(
                              context,
                              ref,
                              TransactionType.distributed,
                            ),
                            icon: const Icon(Icons.remove_circle_outline),
                            label: const Text('Distribute'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Transaction history header
                    Row(
                      children: [
                        Icon(Icons.history, size: 20, color: colors.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Transaction History',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // Transaction list
            txnsAsync.when(
              data: (txns) => txns.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Card(
                          elevation: 0,
                          color: colors.surfaceContainerLow,
                          child: const Padding(
                            padding: EdgeInsets.all(32),
                            child: Center(
                              child: Text('No transactions yet'),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.separated(
                        itemCount: txns.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 4),
                        itemBuilder: (context, index) =>
                            _TransactionTile(txn: txns[index]),
                      ),
                    ),
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: Center(child: Text('Error: $e')),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  void _showTransactionDialog(
    BuildContext context,
    WidgetRef ref,
    TransactionType type,
  ) {
    final quantityController = TextEditingController();
    final notesController = TextEditingController();
    final isIntake = type == TransactionType.intake;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          24 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isIntake ? 'Record Intake' : 'Record Distribution',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(
                  isIntake ? Icons.add_circle_outline : Icons.remove_circle_outline,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                final qty = int.tryParse(quantityController.text.trim());
                if (qty == null || qty <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a valid quantity')),
                  );
                  return;
                }
                final txn = Transaction(
                  id: '',
                  itemId: itemId,
                  type: type,
                  quantity: qty,
                  createdBy: 'TODO_CURRENT_USER_ID',
                  notes: notesController.text.trim(),
                  createdAt: DateTime.now(),
                );
                ref.read(inventoryRepositoryProvider).addTransaction(txn);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isIntake
                          ? 'Intake of $qty recorded'
                          : 'Distribution of $qty recorded',
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(isIntake ? 'Record Intake' : 'Record Distribution'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stock indicator
// ---------------------------------------------------------------------------

class _StockIndicator extends StatelessWidget {
  final int stock;
  final String label;
  final ColorScheme colors;

  const _StockIndicator(
      {required this.stock, required this.colors, this.label = 'Stock'});

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    final IconData icon;

    if (stock <= 0) {
      bg = colors.errorContainer;
      fg = colors.onErrorContainer;
      icon = Icons.warning_amber_rounded;
    } else if (stock < 10) {
      bg = Colors.orange.shade100;
      fg = Colors.orange.shade900;
      icon = Icons.trending_down;
    } else {
      bg = colors.primaryContainer;
      fg = colors.onPrimaryContainer;
      icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 4),
          Text(
            '$label: $stock',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold, color: fg),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Transaction tile
// ---------------------------------------------------------------------------

class _TransactionTile extends StatelessWidget {
  final Transaction txn;
  const _TransactionTile({required this.txn});

  @override
  Widget build(BuildContext context) {
    final isIntake = txn.type == TransactionType.intake;
    final colors = Theme.of(context).colorScheme;
    final dateFmt = DateFormat.yMMMd().add_jm();

    return Card(
      elevation: 0,
      color: isIntake
          ? Colors.green.withValues(alpha: 0.06)
          : Colors.red.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isIntake
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.red.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isIntake ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                color: isIntake ? Colors.green.shade700 : Colors.red.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isIntake ? 'Intake' : 'Distributed',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (txn.notes.isNotEmpty)
                    Text(
                      txn.notes,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  Text(
                    dateFmt.format(txn.createdAt.toLocal()),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: colors.outline),
                  ),
                ],
              ),
            ),
            Text(
              '${isIntake ? '+' : '-'}${txn.quantity}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isIntake ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
