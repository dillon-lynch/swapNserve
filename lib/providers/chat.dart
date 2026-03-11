import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/chat_message.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'chat.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<ChatMessage>> chatMessages(Ref ref, String eventId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.eventMessages)
      .where('eventId', isEqualTo: eventId)
      .orderBy('sentAt', descending: false)
      .snapshots()
      .map((snap) => snap.docs.map(ChatMessage.fromFirestore).toList());
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
ChatActions chatActions(Ref ref) {
  return ChatActions(ref.watch(firestoreProvider));
}

class ChatActions {
  final FirebaseFirestore _firestore;
  ChatActions(this._firestore);

  Future<void> sendMessage(String eventId, ChatMessage message) async {
    await _firestore
        .collection(FirestorePaths.eventMessages)
        .add(message.toMap());
  }
}
