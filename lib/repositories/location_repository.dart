import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/location.dart';

class LocationRepository {
  final FirebaseFirestore _firestore;

  LocationRepository(this._firestore);

  CollectionReference get _ref =>
      _firestore.collection(FirestorePaths.locations);

  Stream<List<Location>> watchAll() {
    return _ref
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map(Location.fromFirestore).toList());
  }

  Future<Location> get(String locationId) async {
    final doc = await _ref.doc(locationId).get();
    return Location.fromFirestore(doc);
  }

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
