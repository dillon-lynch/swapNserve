import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String text;
  final DateTime sentAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.sentAt,
  });

  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      senderId: data['senderId'] as String,
      senderName: data['senderName'] as String,
      text: data['text'] as String,
      sentAt: (data['sentAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
    'senderId': senderId,
    'senderName': senderName,
    'text': text,
    'sentAt': Timestamp.fromDate(sentAt),
  };
}
