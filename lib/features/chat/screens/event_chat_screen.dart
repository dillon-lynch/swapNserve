import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:swap_n_serve/models/chat_message.dart';
import 'package:swap_n_serve/providers/chat.dart';
import 'package:swap_n_serve/providers/event.dart';
import 'package:swap_n_serve/providers/user.dart';

class EventChatScreen extends ConsumerStatefulWidget {
  final String eventId;

  const EventChatScreen({super.key, required this.eventId});

  @override
  ConsumerState<EventChatScreen> createState() => _EventChatScreenState();
}

class _EventChatScreenState extends ConsumerState<EventChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;

    final message = ChatMessage(
      id: '',
      eventId: widget.eventId,
      senderId: uid,
      message: text,
      timestamp: DateTime.now(),
    );

    await ref.read(chatRepositoryProvider).sendMessage(message);
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(currentUserIdProvider);
    final eventAsync = ref.watch(eventProvider(widget.eventId));
    final messagesAsync = ref.watch(chatMessagesProvider(widget.eventId));
    final colors = Theme.of(context).colorScheme;

    // ── Not signed in ──
    if (uid == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Event Chat')),
        body: const Center(child: Text('You must be signed in.')),
      );
    }

    // ── Staff-only gate ──
    return eventAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Event Chat')),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Event Chat')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (event) {
        final isStaff = event.assignedUsers.contains(uid);
        if (!isStaff) {
          return Scaffold(
            appBar: AppBar(title: Text(event.title)),
            body: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline, size: 56, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Staff only – you are not assigned to this event.'),
                ],
              ),
            ),
          );
        }

        // ── Chat UI ──
        return Scaffold(
          appBar: AppBar(title: Text('${event.title} – Chat')),
          body: Column(
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
                    _scrollToBottom();
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isMe = msg.senderId == uid;
                        return _ChatBubble(
                          message: msg,
                          isMe: isMe,
                        );
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
                  border: Border(
                      top: BorderSide(color: colors.outlineVariant)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
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
                        onSubmitted: (_) => _send(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _send,
                      icon: const Icon(Icons.send, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Chat bubble — resolves sender display name from userProvider
// ─────────────────────────────────────────────────────────────────────────────

class _ChatBubble extends ConsumerWidget {
  final ChatMessage message;
  final bool isMe;
  const _ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
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
