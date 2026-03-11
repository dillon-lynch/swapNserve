import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/chat_message.dart';
import 'package:swap_n_serve/providers/firebase.dart';
import 'package:swap_n_serve/repositories/chat_repository.dart';

part 'chat.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  return ChatRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<ChatMessage>> chatMessages(Ref ref, String eventId) {
  return ref.watch(chatRepositoryProvider).watchMessages(eventId);
}
