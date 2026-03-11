import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/location.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'location.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<Location>> locationsStream(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.locations)
      .orderBy('name')
      .snapshots()
      .map((snap) => snap.docs.map(Location.fromFirestore).toList());
}

@riverpod
Future<Location> location(Ref ref, String locationId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc = await firestore
      .collection(FirestorePaths.locations)
      .doc(locationId)
      .get();
  return Location.fromFirestore(doc);
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
LocationActions locationActions(Ref ref) {
  return LocationActions(ref.watch(firestoreProvider));
}

class LocationActions {
  final FirebaseFirestore _firestore;
  LocationActions(this._firestore);

  CollectionReference get _ref =>
      _firestore.collection(FirestorePaths.locations);

  Future<String> create(Location location) async {
    final doc = await _ref.add(location.toMap());
    return doc.id;
  }

  Future<void> update(Location location) async {
    await _ref.doc(location.id).update(location.toMap());
  }

  Future<void> delete(String id) async {
    await _ref.doc(id).delete();
  }
}
