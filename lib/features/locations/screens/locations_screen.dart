import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/location.dart';

class LocationsScreen extends ConsumerWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Locations')),
      body: locationsAsync.when(
        data: (locations) => ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final loc = locations[index];
            return ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(loc.name),
              subtitle: Text(loc.address),
              onTap: () {
                // TODO: Navigate to location analytics
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add location
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
