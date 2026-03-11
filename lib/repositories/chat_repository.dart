import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/chat_message.dart';

class ChatRepository {
  final FirebaseFirestore _firestore;

  ChatRepository(this._firestore);

  CollectionReference get _ref =>
      _firestore.collection(FirestorePaths.eventMessages);

  /// Real-time stream of messages for a single event, ordered oldest-first.
  Stream<List<ChatMessage>> watchMessages(String eventId) {
    return _ref
        .where('eventId', isEqualTo: eventId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map(ChatMessage.fromFirestore).toList());
  }

  Future<void> sendMessage(ChatMessage message) async {
    await _ref.add(message.toMap());
  }
}
