import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/event.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'event.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<Event>> eventsStream(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.events)
      .orderBy('startDate', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map(Event.fromFirestore).toList());
}

@riverpod
Future<Event> event(Ref ref, String eventId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc = await firestore
      .collection(FirestorePaths.events)
      .doc(eventId)
      .get();
  return Event.fromFirestore(doc);
}

@riverpod
Future<List<Event>> eventsForLocation(Ref ref, String locationId) async {
  final firestore = ref.watch(firestoreProvider);
  final snap = await firestore
      .collection(FirestorePaths.events)
      .where('locationId', isEqualTo: locationId)
      .orderBy('startDate', descending: true)
      .get();
  return snap.docs.map(Event.fromFirestore).toList();
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
EventActions eventActions(Ref ref) {
  return EventActions(ref.watch(firestoreProvider));
}

class EventActions {
  final FirebaseFirestore _firestore;
  EventActions(this._firestore);

  CollectionReference get _ref => _firestore.collection(FirestorePaths.events);

  Future<String> create(Event event) async {
    final doc = await _ref.add(event.toMap());
    return doc.id;
  }

  Future<void> update(Event event) async {
    await _ref.doc(event.id).update(event.toMap());
  }

  Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}
