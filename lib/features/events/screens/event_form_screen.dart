import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/app_user.dart';
import 'package:swap_n_serve/models/event.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/location.dart';
import 'package:swap_n_serve/providers/user.dart';

/// Shared screen for creating and editing events.
/// Pass [event] to enter edit mode; omit it for create mode.
class EventFormScreen extends ConsumerStatefulWidget {
  final Event? event;
  const EventFormScreen({super.key, this.event});

  @override
  ConsumerState<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends ConsumerState<EventFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _notesCtrl;

  String? _locationId;
  late DateTime _startDate;
  late TimeOfDay _startTime;
  late DateTime _endDate;
  late TimeOfDay _endTime;
  List<String> _assignedUsers = [];
  bool _saving = false;

  bool get _isEditing => widget.event != null;

  @override
  void initState() {
    super.initState();
    final e = widget.event;
    _titleCtrl = TextEditingController(text: e?.title ?? '');
    _notesCtrl = TextEditingController(text: e?.notes ?? '');
    _locationId = e?.locationId;
    _startDate = e?.startDate ?? DateTime.now();
    _startTime =
        TimeOfDay.fromDateTime(e?.startDate ?? DateTime.now());
    _endDate = e?.endDate ?? DateTime.now().add(const Duration(hours: 2));
    _endTime = TimeOfDay.fromDateTime(
        e?.endDate ?? DateTime.now().add(const Duration(hours: 2)));
    _assignedUsers = List<String>.from(e?.assignedUsers ?? []);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  Future<void> _pickDate(
      {required DateTime initial,
      required ValueChanged<DateTime> onPicked}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) onPicked(picked);
  }

  Future<void> _pickTime(
      {required TimeOfDay initial,
      required ValueChanged<TimeOfDay> onPicked}) async {
    final picked =
        await showTimePicker(context: context, initialTime: initial);
    if (picked != null) onPicked(picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_locationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location')),
      );
      return;
    }

    setState(() => _saving = true);

    final start = _combine(_startDate, _startTime);
    final end = _combine(_endDate, _endTime);

    if (end.isBefore(start)) {
      setState(() => _saving = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    final repo = ref.read(eventRepositoryProvider);

    try {
      if (_isEditing) {
        await repo.update(widget.event!.copyWith(
          title: _titleCtrl.text.trim(),
          locationId: _locationId!,
          startDate: start,
          endDate: end,
          notes: _notesCtrl.text.trim(),
          assignedUsers: _assignedUsers,
        ));
      } else {
        await repo.create(Event(
          id: '',
          title: _titleCtrl.text.trim(),
          locationId: _locationId!,
          startDate: start,
          endDate: end,
          notes: _notesCtrl.text.trim(),
          assignedUsers: _assignedUsers,
          createdAt: DateTime.now(),
        ));
      }
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
    final colors = Theme.of(context).colorScheme;
    final locationsAsync = ref.watch(locationsStreamProvider);
    final usersAsync = ref.watch(usersStreamProvider);
    final dateFmt = DateFormat('MMM d, y');
    final timeFmt = DateFormat('h:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Event' : 'Create Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Title ──
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  prefixIcon: Icon(Icons.event),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Title is required' : null,
              ),
              const SizedBox(height: 20),

              // ── Location picker ──
              locationsAsync.when(
                data: (locations) => DropdownButtonFormField<String>(
                  value: _locationId,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                  items: locations
                      .map((l) =>
                          DropdownMenuItem(value: l.id, child: Text(l.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _locationId = v),
                  validator: (v) => v == null ? 'Select a location' : null,
                ),
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Error loading locations: $e'),
              ),
              const SizedBox(height: 24),

              // ── Date & Time ──
              Text('Schedule',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Start
              Row(
                children: [
                  Expanded(
                    child: _DateTimeTile(
                      label: 'Start Date',
                      value: dateFmt.format(_startDate),
                      icon: Icons.calendar_today,
                      onTap: () => _pickDate(
                        initial: _startDate,
                        onPicked: (d) => setState(() => _startDate = d),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateTimeTile(
                      label: 'Start Time',
                      value: timeFmt.format(_combine(_startDate, _startTime)),
                      icon: Icons.schedule,
                      onTap: () => _pickTime(
                        initial: _startTime,
                        onPicked: (t) => setState(() => _startTime = t),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // End
              Row(
                children: [
                  Expanded(
                    child: _DateTimeTile(
                      label: 'End Date',
                      value: dateFmt.format(_endDate),
                      icon: Icons.calendar_today,
                      onTap: () => _pickDate(
                        initial: _endDate,
                        onPicked: (d) => setState(() => _endDate = d),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DateTimeTile(
                      label: 'End Time',
                      value: timeFmt.format(_combine(_endDate, _endTime)),
                      icon: Icons.schedule,
                      onTap: () => _pickTime(
                        initial: _endTime,
                        onPicked: (t) => setState(() => _endTime = t),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Assign Staff ──
              Text('Assign Staff',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              usersAsync.when(
                data: (users) => _StaffSelector(
                  allUsers: users,
                  selectedIds: _assignedUsers,
                  onChanged: (ids) => setState(() => _assignedUsers = ids),
                ),
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Error loading staff: $e'),
              ),
              const SizedBox(height: 20),

              // ── Notes ──
              TextFormField(
                controller: _notesCtrl,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
                minLines: 2,
                maxLines: 5,
              ),
              const SizedBox(height: 28),

              // ── Save ──
              FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(_isEditing ? Icons.save : Icons.check),
                label: Text(_isEditing ? 'Save Changes' : 'Create Event'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Date/time tile ──────────────────────────────────────────────────────────

class _DateTimeTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  const _DateTimeTile(
      {required this.label,
      required this.value,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.outline),
        ),
        child: Row(
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
                  const SizedBox(height: 2),
                  Text(value,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Staff selector (multi-select chips) ─────────────────────────────────────

class _StaffSelector extends StatelessWidget {
  final List<AppUser> allUsers;
  final List<String> selectedIds;
  final ValueChanged<List<String>> onChanged;
  const _StaffSelector(
      {required this.allUsers,
      required this.selectedIds,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    if (allUsers.isEmpty) {
      return const Text('No staff members found.',
          style: TextStyle(color: Colors.grey));
    }
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: allUsers.map((user) {
        final selected = selectedIds.contains(user.id);
        return FilterChip(
          avatar: CircleAvatar(
            radius: 14,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Text(
              user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
              style: const TextStyle(fontSize: 11),
            ),
          ),
          label: Text(user.name),
          selected: selected,
          onSelected: (val) {
            final updated = List<String>.from(selectedIds);
            if (val) {
              updated.add(user.id);
            } else {
              updated.remove(user.id);
            }
            onChanged(updated);
          },
        );
      }).toList(),
    );
  }
}
