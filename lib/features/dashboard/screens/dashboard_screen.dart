import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DashboardTile(
            icon: Icons.event,
            label: 'Events',
            onTap: () => context.go('/events'),
          ),
          _DashboardTile(
            icon: Icons.inventory_2,
            label: 'Inventory',
            onTap: () => context.go('/inventory'),
          ),
          _DashboardTile(
            icon: Icons.location_on,
            label: 'Locations',
            onTap: () => context.go('/locations'),
          ),
          _DashboardTile(
            icon: Icons.people,
            label: 'Staff',
            onTap: () => context.go('/staff'),
          ),
          _DashboardTile(
            icon: Icons.analytics,
            label: 'Analytics',
            onTap: () => context.go('/analytics'),
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
