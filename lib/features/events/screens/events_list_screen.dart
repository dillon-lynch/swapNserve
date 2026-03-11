import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/event.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/transaction.dart';
import 'package:swap_n_serve/features/events/screens/event_form_screen.dart';

class EventsListScreen extends ConsumerStatefulWidget {
  const EventsListScreen({super.key});

  @override
  ConsumerState<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
  String _filter = 'all'; // 'all', 'upcoming', 'past'

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsStreamProvider);
    final colors = Theme.of(context).colorScheme;
    final now = DateTime.now();

    return Scaffold(
      body: eventsAsync.when(
        data: (events) {
          final filtered = switch (_filter) {
            'upcoming' => events.where((e) => e.endDate.isAfter(now)).toList(),
            'past' => events.where((e) => e.endDate.isBefore(now)).toList(),
            _ => events,
          };

          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                title: const Text('Events'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => showSearch(
                      context: context,
                      delegate: _EventSearchDelegate(events),
                    ),
                  ),
                ],
              ),

              // ── Filter chips ──
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        selected: _filter == 'all',
                        onSelected: () => setState(() => _filter = 'all'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Upcoming',
                        selected: _filter == 'upcoming',
                        onSelected: () => setState(() => _filter = 'upcoming'),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Past',
                        selected: _filter == 'past',
                        onSelected: () => setState(() => _filter = 'past'),
                      ),
                    ],
                  ),
                ),
              ),

              if (filtered.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.event_busy, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('No events found',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final event = filtered[index];
                      return _EventCard(event: event);
                    },
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EventFormScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('New Event'),
      ),
    );
  }
}

// ─── Event Card ──────────────────────────────────────────────────────────────

class _EventCard extends ConsumerWidget {
  final Event event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final isLive =
        event.startDate.isBefore(now) && event.endDate.isAfter(now);
    final isPast = event.endDate.isBefore(now);
    final distAsync = ref.watch(eventDistributionTotalProvider(event.id));
    final dateFmt = DateFormat('MMM d, y');
    final timeFmt = DateFormat('h:mm a');

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: isLive ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isLive
            ? BorderSide(color: colors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => context.go('/events/${event.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ──
              Row(
                children: [
                  if (isLive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 8),
                          SizedBox(width: 4),
                          Text('LIVE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  if (isPast)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('Past',
                          style: TextStyle(
                              fontSize: 11, color: colors.onSurfaceVariant)),
                    ),
                  Expanded(
                    child: Text(
                      event.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.chevron_right,
                      color: colors.onSurfaceVariant, size: 20),
                ],
              ),

              const SizedBox(height: 10),

              // ── Date / time row ──
              Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 14, color: colors.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text(
                    dateFmt.format(event.startDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.schedule,
                      size: 14, color: colors.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    '${timeFmt.format(event.startDate)} – ${timeFmt.format(event.endDate)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ── Stats row ──
              Row(
                children: [
                  _StatChip(
                    icon: Icons.people_outline,
                    label: '${event.assignedUsers.length} staff',
                    color: colors.primary,
                  ),
                  const SizedBox(width: 10),
                  distAsync.when(
                    data: (total) => _StatChip(
                      icon: Icons.inventory_2_outlined,
                      label: '$total distributed',
                      color: colors.tertiary,
                    ),
                    loading: () => const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),

              if (event.notes.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  event.notes,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Small helper widgets ────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;
  const _FilterChip(
      {required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _StatChip(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: color)),
      ],
    );
  }
}

// ─── Search delegate ─────────────────────────────────────────────────────────

class _EventSearchDelegate extends SearchDelegate<String> {
  final List<Event> events;
  _EventSearchDelegate(this.events);

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final q = query.toLowerCase();
    final results =
        events.where((e) => e.title.toLowerCase().contains(q)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final e = results[index];
        return ListTile(
          title: Text(e.title),
          subtitle: Text(DateFormat('MMM d, y').format(e.startDate)),
          onTap: () {
            close(context, '');
            context.go('/events/${e.id}');
          },
        );
      },
    );
  }
}
