import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/location.dart';
import 'package:swap_n_serve/providers/transaction.dart';

class LocationAnalyticsScreen extends ConsumerWidget {
  final String locationId;

  const LocationAnalyticsScreen({super.key, required this.locationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(locationProvider(locationId));
    final eventsAsync = ref.watch(eventsForLocationProvider(locationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Location Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            locationAsync.when(
              data: (loc) => Text(
                loc.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              loading: () => const Text('Loading...'),
              error: (e, _) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),
            Text(
              'Events at this location',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: eventsAsync.when(
                data: (events) => ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final distAsync = ref.watch(
                      eventDistributionTotalProvider(event.id),
                    );
                    return Card(
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Text(
                          '${event.startDate.toLocal()} – ${event.endDate.toLocal()}',
                        ),
                        trailing: distAsync.when(
                          data: (total) => Chip(label: Text('$total dist.')),
                          loading: () => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          error: (_, __) => const Chip(label: Text('?')),
                        ),
                      ),
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
