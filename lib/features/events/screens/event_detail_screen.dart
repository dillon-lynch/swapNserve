import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/transaction.dart';

class EventDetailScreen extends ConsumerWidget {
  final String eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventProvider(eventId));
    final distributionAsync = ref.watch(
      eventDistributionTotalProvider(eventId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Event Details')),
      body: eventAsync.when(
        data: (event) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text('${event.startDate.toLocal()} – ${event.endDate.toLocal()}'),
              const SizedBox(height: 8),
              Text('Users assigned: ${event.assignedUsers.length}'),
              const SizedBox(height: 8),
              distributionAsync.when(
                data: (total) => Text('Items distributed: $total'),
                loading: () => const Text('Calculating...'),
                error: (e, _) => Text('Error: $e'),
              ),
              if (event.notes.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(event.notes),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
