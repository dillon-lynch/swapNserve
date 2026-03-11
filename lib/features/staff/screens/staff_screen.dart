import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swap_n_serve/providers/staff.dart';

class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Staff')),
      body: staffAsync.when(
        data: (staffList) => ListView.builder(
          itemCount: staffList.length,
          itemBuilder: (context, index) {
            final staff = staffList[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: staff.avatarUrl.isNotEmpty
                    ? NetworkImage(staff.avatarUrl)
                    : null,
                child: staff.avatarUrl.isEmpty
                    ? Text(staff.name[0].toUpperCase())
                    : null,
              ),
              title: Text(staff.name),
              subtitle: Text('${staff.email} • ${staff.role.name}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
