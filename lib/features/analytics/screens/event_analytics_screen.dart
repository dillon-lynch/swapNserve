import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/transaction.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/inventory.dart';
import 'package:swap_n_serve/providers/transaction.dart';
import 'package:swap_n_serve/providers/user.dart';

class EventAnalyticsScreen extends ConsumerWidget {
  final String eventId;

  const EventAnalyticsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventProvider(eventId));
    final distTotalAsync =
        ref.watch(eventDistributionTotalProvider(eventId));
    final txnsAsync = ref.watch(eventTransactionsProvider(eventId));
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Event Analytics')),
      body: eventAsync.when(
        data: (event) {
          final duration = event.endDate.difference(event.startDate);
          final hours = duration.inMinutes / 60;
          final dateFmt = DateFormat('MMM d, y  •  h:mm a');

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Event header ──
              Text(event.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                '${dateFmt.format(event.startDate)}  →  ${DateFormat('h:mm a').format(event.endDate)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 20),

              // ── Summary cards ──
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.people,
                      label: 'Staff',
                      value: '${event.assignedUsers.length}',
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: distTotalAsync.when(
                      data: (total) => _SummaryCard(
                        icon: Icons.inventory_2,
                        label: 'Items Out',
                        value: '$total',
                        color: colors.tertiary,
                      ),
                      loading: () => _SummaryCard(
                        icon: Icons.inventory_2,
                        label: 'Items Out',
                        value: '…',
                        color: colors.tertiary,
                      ),
                      error: (_, __) => _SummaryCard(
                        icon: Icons.inventory_2,
                        label: 'Items Out',
                        value: '?',
                        color: colors.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      icon: Icons.schedule,
                      label: 'Duration',
                      value: '${hours.toStringAsFixed(1)}h',
                      color: colors.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Distribution breakdown ──
              Text('Distribution Breakdown',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              txnsAsync.when(
                data: (txns) {
                  final distributed = txns
                      .where(
                          (t) => t.type == TransactionType.distributed)
                      .toList();
                  if (distributed.isEmpty) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                            child: Text('No distributions recorded',
                                style: TextStyle(color: Colors.grey))),
                      ),
                    );
                  }

                  // Group by item
                  final byItem = <String, int>{};
                  for (final t in distributed) {
                    byItem[t.itemId] =
                        (byItem[t.itemId] ?? 0) + t.quantity;
                  }
                  final entries = byItem.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));
                  final maxQty = entries.first.value;

                  return Column(
                    children: entries.map((e) {
                      return _BreakdownRow(
                        itemId: e.key,
                        quantity: e.value,
                        maxQuantity: maxQty,
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(
                    child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 24),

              // ── Assigned staff list ──
              Text('Assigned Staff',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...event.assignedUsers.map((uid) {
                final userAsync = ref.watch(userProvider(uid));
                return userAsync.when(
                  data: (user) => ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: colors.primaryContainer,
                      child: Text(
                        user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                            color: colors.onPrimaryContainer,
                            fontSize: 12),
                      ),
                    ),
                    title: Text(user.name),
                    trailing: Chip(
                      label: Text(user.role.name,
                          style: const TextStyle(fontSize: 10)),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  loading: () => const ListTile(
                    dense: true,
                    title: Text('Loading…'),
                  ),
                  error: (_, __) => ListTile(
                    dense: true,
                    title: Text(uid),
                  ),
                );
              }),

              const SizedBox(height: 24),

              // ── Full transaction log ──
              Text('Transaction Log',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              txnsAsync.when(
                data: (txns) {
                  if (txns.isEmpty) {
                    return const Text('No transactions.',
                        style: TextStyle(color: Colors.grey));
                  }
                  return Column(
                    children: txns.map((t) {
                      final isDist =
                          t.type == TransactionType.distributed;
                      final color =
                          isDist ? Colors.orange : Colors.green;
                      final itemAsync =
                          ref.watch(inventoryItemProvider(t.itemId));
                      return Card(
                        child: ListTile(
                          dense: true,
                          leading: Icon(
                              isDist ? Icons.output : Icons.input,
                              color: color,
                              size: 20),
                          title: itemAsync.when(
                            data: (item) => Text(item.name),
                            loading: () => const Text('…'),
                            error: (_, __) => Text(t.itemId),
                          ),
                          subtitle: Text(t.notes.isNotEmpty
                              ? t.notes
                              : t.type.name),
                          trailing: Text(
                            '${isDist ? "-" : "+"}${t.quantity}',
                            style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(
                    child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

// ─── Summary card ────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _SummaryCard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                        fontWeight: FontWeight.bold, color: color)),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

// ─── Breakdown bar row ───────────────────────────────────────────────────────

class _BreakdownRow extends ConsumerWidget {
  final String itemId;
  final int quantity;
  final int maxQuantity;
  const _BreakdownRow(
      {required this.itemId,
      required this.quantity,
      required this.maxQuantity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final itemAsync = ref.watch(inventoryItemProvider(itemId));
    final fraction = maxQuantity > 0 ? quantity / maxQuantity : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: itemAsync.when(
              data: (item) => Text(item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall),
              loading: () => const Text('…'),
              error: (_, __) => Text(itemId,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 14,
                backgroundColor: colors.surfaceContainerHighest,
                color: colors.tertiary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text('$quantity',
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
