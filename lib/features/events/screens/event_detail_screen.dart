import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/chat_message.dart';
import 'package:swap_n_serve/models/event.dart';
import 'package:swap_n_serve/models/inventory_item.dart';
import 'package:swap_n_serve/models/transaction.dart';
import 'package:swap_n_serve/providers/chat.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/inventory.dart';
import 'package:swap_n_serve/providers/transaction.dart';
import 'package:swap_n_serve/providers/user.dart';
import 'package:swap_n_serve/features/events/screens/event_form_screen.dart';

class EventDetailScreen extends ConsumerStatefulWidget {
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  final _chatCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _chatCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventProvider(widget.eventId));

    return eventAsync.when(
      data: (event) => _EventDetailBody(
        event: event,
        tabCtrl: _tabCtrl,
        chatCtrl: _chatCtrl,
        scrollCtrl: _scrollCtrl,
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) =>
          Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}

// ─── Main body ───────────────────────────────────────────────────────────────

class _EventDetailBody extends ConsumerWidget {
  final Event event;
  final TabController tabCtrl;
  final TextEditingController chatCtrl;
  final ScrollController scrollCtrl;
  const _EventDetailBody({
    required this.event,
    required this.tabCtrl,
    required this.chatCtrl,
    required this.scrollCtrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final isLive =
        event.startDate.isBefore(now) && event.endDate.isAfter(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit event',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => EventFormScreen(event: event)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Analytics',
            onPressed: () =>
                context.go('/events/${event.id}/analytics'),
          ),
        ],
        bottom: TabBar(
          controller: tabCtrl,
          tabs: const [
            Tab(icon: Icon(Icons.info_outline), text: 'Info'),
            Tab(icon: Icon(Icons.people_outline), text: 'Staff'),
            Tab(icon: Icon(Icons.inventory_2_outlined), text: 'Items'),
            Tab(icon: Icon(Icons.chat_outlined), text: 'Chat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabCtrl,
        children: [
          _InfoTab(event: event, isLive: isLive),
          _StaffTab(event: event),
          _DistributionsTab(event: event),
          _ChatTab(
            eventId: event.id,
            chatCtrl: chatCtrl,
            scrollCtrl: scrollCtrl,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 – Event Info
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoTab extends ConsumerWidget {
  final Event event;
  final bool isLive;
  const _InfoTab({required this.event, required this.isLive});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final dateFmt = DateFormat('EEEE, MMM d, y');
    final timeFmt = DateFormat('h:mm a');
    final distAsync =
        ref.watch(eventDistributionTotalProvider(event.id));

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // ── Status badge ──
        if (isLive)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color: Colors.red, size: 10),
                SizedBox(width: 6),
                Text('Event is live now',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600)),
              ],
            ),
          ),

        // ── Schedule card ──
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Schedule',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _InfoRow(
                    icon: Icons.calendar_today,
                    label: 'Start',
                    value:
                        '${dateFmt.format(event.startDate)}  •  ${timeFmt.format(event.startDate)}'),
                const SizedBox(height: 8),
                _InfoRow(
                    icon: Icons.event_available,
                    label: 'End',
                    value:
                        '${dateFmt.format(event.endDate)}  •  ${timeFmt.format(event.endDate)}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // ── Quick stats ──
        Row(
          children: [
            Expanded(
              child: _QuickStatCard(
                icon: Icons.people,
                value: '${event.assignedUsers.length}',
                label: 'Staff Assigned',
                color: colors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: distAsync.when(
                data: (total) => _QuickStatCard(
                  icon: Icons.inventory_2,
                  value: '$total',
                  label: 'Distributed',
                  color: colors.tertiary,
                ),
                loading: () => const _QuickStatCard(
                  icon: Icons.inventory_2,
                  value: '...',
                  label: 'Distributed',
                  color: Colors.grey,
                ),
                error: (_, __) => const _QuickStatCard(
                  icon: Icons.inventory_2,
                  value: '?',
                  label: 'Distributed',
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

        if (event.notes.isNotEmpty) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Notes',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(event.notes),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: colors.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: colors.onSurfaceVariant)),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const _QuickStatCard(
      {required this.icon,
      required this.value,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 – Assigned Staff
// ═══════════════════════════════════════════════════════════════════════════════

class _StaffTab extends ConsumerWidget {
  final Event event;
  const _StaffTab({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersStreamProvider);

    if (event.assignedUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_off, size: 56, color: Colors.grey),
            SizedBox(height: 8),
            Text('No staff assigned yet',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return usersAsync.when(
      data: (allUsers) {
        final assigned = allUsers
            .where((u) => event.assignedUsers.contains(u.id))
            .toList();
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: assigned.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final user = assigned[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Chip(
                label: Text(user.role.name,
                    style: const TextStyle(fontSize: 11)),
                visualDensity: VisualDensity.compact,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 – Items Distributed
// ═══════════════════════════════════════════════════════════════════════════════

class _DistributionsTab extends ConsumerWidget {
  final Event event;
  const _DistributionsTab({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnsAsync =
        ref.watch(eventTransactionsProvider(event.id));
    final colors = Theme.of(context).colorScheme;

    return Stack(
      children: [
        txnsAsync.when(
          data: (txns) {
            if (txns.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined,
                        size: 56, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No distributions yet',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: txns.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final txn = txns[index];
                return _TransactionTile(txn: txn);
              },
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),

        // ── Record distribution FAB ──
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton.extended(
            heroTag: 'record_dist',
            onPressed: () => _showDistributionSheet(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Record Distribution'),
          ),
        ),
      ],
    );
  }

  void _showDistributionSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _RecordDistributionSheet(eventId: event.id),
    );
  }
}

// ─── Transaction tile ────────────────────────────────────────────────────────

class _TransactionTile extends ConsumerWidget {
  final Transaction txn;
  const _TransactionTile({required this.txn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isDistributed = txn.type == TransactionType.distributed;
    final color = isDistributed ? Colors.orange : Colors.green;
    final itemAsync = ref.watch(inventoryItemProvider(txn.itemId));
    final dateFmt = DateFormat('MMM d, h:mm a');

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(
            isDistributed ? Icons.output : Icons.input,
            color: color,
            size: 20,
          ),
        ),
        title: itemAsync.when(
          data: (item) => Text(item.name,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          loading: () => const Text('Loading...'),
          error: (_, __) => Text('Item ${txn.itemId}'),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${isDistributed ? "Distributed" : "Intake"} × ${txn.quantity}',
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
            if (txn.notes.isNotEmpty)
              Text(txn.notes,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
        trailing: Text(
          dateFmt.format(txn.createdAt),
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: colors.onSurfaceVariant),
        ),
        isThreeLine: txn.notes.isNotEmpty,
      ),
    );
  }
}

// ─── Record distribution bottom sheet ────────────────────────────────────────

class _RecordDistributionSheet extends ConsumerStatefulWidget {
  final String eventId;
  const _RecordDistributionSheet({required this.eventId});

  @override
  ConsumerState<_RecordDistributionSheet> createState() =>
      _RecordDistributionSheetState();
}

class _RecordDistributionSheetState
    extends ConsumerState<_RecordDistributionSheet> {
  String? _selectedItemId;
  final _qtyCtrl = TextEditingController(text: '1');
  final _notesCtrl = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final qty = int.tryParse(_qtyCtrl.text.trim());
    if (_selectedItemId == null || qty == null || qty <= 0) return;

    setState(() => _saving = true);
    try {
      await ref.read(inventoryRepositoryProvider).addTransaction(
            Transaction(
              id: '',
              itemId: _selectedItemId!,
              type: TransactionType.distributed,
              quantity: qty,
              eventId: widget.eventId,
              createdBy: 'current_user', // TODO: wire real user
              notes: _notesCtrl.text.trim(),
              createdAt: DateTime.now(),
            ),
          );
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(inventoryStreamProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Record Distribution',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // ── Item picker ──
          itemsAsync.when(
            data: (items) => DropdownButtonFormField<String>(
              value: _selectedItemId,
              decoration: const InputDecoration(
                labelText: 'Select Item',
                prefixIcon: Icon(Icons.inventory_2),
                border: OutlineInputBorder(),
              ),
              items: items
                  .map((i) => DropdownMenuItem(
                      value: i.id,
                      child: Text(i.name)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedItemId = v),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          // ── Quantity ──
          TextFormField(
            controller: _qtyCtrl,
            decoration: const InputDecoration(
              labelText: 'Quantity',
              prefixIcon: Icon(Icons.numbers),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // ── Notes ──
          TextFormField(
            controller: _notesCtrl,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              prefixIcon: Icon(Icons.notes),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: (_saving || _selectedItemId == null) ? null : _submit,
            icon: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white))
                : const Icon(Icons.check),
            label: const Text('Record'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 4 – Event Chat (inline)
// ═══════════════════════════════════════════════════════════════════════════════

class _ChatTab extends ConsumerWidget {
  final String eventId;
  final TextEditingController chatCtrl;
  final ScrollController scrollCtrl;
  const _ChatTab({
    required this.eventId,
    required this.chatCtrl,
    required this.scrollCtrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(eventId));
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 56, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('No messages yet',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (scrollCtrl.hasClients) {
                  scrollCtrl.animateTo(
                    scrollCtrl.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                  );
                }
              });
              return ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return _ChatBubble(message: msg);
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          ),
        ),

        // ── Input bar ──
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colors.surface,
            border:
                Border(top: BorderSide(color: colors.outlineVariant)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: chatCtrl,
                  decoration: InputDecoration(
                    hintText: 'Type a message…',
                    filled: true,
                    fillColor: colors.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                  onSubmitted: (_) => _send(ref),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () => _send(ref),
                icon: const Icon(Icons.send, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _send(WidgetRef ref) {
    final text = chatCtrl.text.trim();
    if (text.isEmpty) return;
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    ref.read(chatRepositoryProvider).sendMessage(ChatMessage(
          id: '',
          eventId: eventId,
          senderId: uid,
          message: text,
          timestamp: DateTime.now(),
        ));
    chatCtrl.clear();
  }
}

class _ChatBubble extends ConsumerWidget {
  final ChatMessage message;
  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final uid = ref.watch(currentUserIdProvider);
    final isMe = message.senderId == uid;
    final senderAsync = ref.watch(userProvider(message.senderId));
    final senderName = senderAsync.whenOrNull(data: (u) => u.name) ?? '…';

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isMe ? 'You' : senderName,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('h:mm a').format(message.timestamp),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isMe
                      ? colors.primaryContainer
                      : colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(message.message),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
