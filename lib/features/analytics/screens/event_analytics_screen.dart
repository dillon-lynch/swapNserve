import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/transaction.dart';

class EventAnalyticsScreen extends ConsumerWidget {
  final String eventId;

  const EventAnalyticsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventProvider(eventId));
    final distributionAsync = ref.watch(
      eventDistributionTotalProvider(eventId),
    );
    final txnsAsync = ref.watch(eventTransactionsProvider(eventId));

    return Scaffold(
      appBar: AppBar(title: const Text('Event Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            eventAsync.when(
              data: (event) => Text(
                event.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              loading: () => const Text('Loading...'),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),
            distributionAsync.when(
              data: (total) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        '$total',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('Items Distributed'),
                    ],
                  ),
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),
            Text('Transactions', style: Theme.of(context).textTheme.titleLarge),
            Expanded(
              child: txnsAsync.when(
                data: (txns) => ListView.builder(
                  itemCount: txns.length,
                  itemBuilder: (context, index) {
                    final t = txns[index];
                    return ListTile(
                      title: Text('${t.type.name} × ${t.quantity}'),
                      subtitle: Text('Item: ${t.itemId}'),
                      trailing: Text(t.createdAt.toLocal().toString()),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
