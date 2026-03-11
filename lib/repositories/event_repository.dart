import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore;

  EventRepository(this._firestore);

  CollectionReference get _ref => _firestore.collection(FirestorePaths.events);

  Stream<List<Event>> watchAll() {
    return _ref
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map(Event.fromFirestore).toList());
  }

  Future<Event> get(String eventId) async {
    final doc = await _ref.doc(eventId).get();
    return Event.fromFirestore(doc);
  }

  Future<List<Event>> getForLocation(String locationId) async {
    final snap = await _ref
        .where('locationId', isEqualTo: locationId)
        .orderBy('startDate', descending: true)
        .get();
    return snap.docs.map(Event.fromFirestore).toList();
  }

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
