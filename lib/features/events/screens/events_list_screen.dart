import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/event.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(eventsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: eventsAsync.when(
        data: (events) => ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Text(event.title),
              subtitle: Text(
                '${event.startDate.toLocal()} – ${event.endDate.toLocal()}',
              ),
              onTap: () {
                // TODO: Navigate to event detail
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to create event form
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
