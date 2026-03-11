import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/staff.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'staff.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<Staff>> staffStream(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.staff)
      .orderBy('name')
      .snapshots()
      .map((snap) => snap.docs.map(Staff.fromFirestore).toList());
}

@riverpod
Future<Staff> staffMember(Ref ref, String staffId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc = await firestore
      .collection(FirestorePaths.staff)
      .doc(staffId)
      .get();
  return Staff.fromFirestore(doc);
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
StaffActions staffActions(Ref ref) {
  return StaffActions(ref.watch(firestoreProvider));
}

class StaffActions {
  final FirebaseFirestore _firestore;
  StaffActions(this._firestore);

  CollectionReference get _ref => _firestore.collection(FirestorePaths.staff);

  /// Creates staff doc using the Auth UID as the document ID.
  Future<void> create(Staff staff) async {
    await _ref.doc(staff.id).set(staff.toMap());
  }

  Future<void> update(Staff staff) async {
    await _ref.doc(staff.id).update(staff.toMap());
  }
}
