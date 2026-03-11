import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/app_user.dart';
import 'package:swap_n_serve/providers/firebase.dart';

part 'user.g.dart';

// ---------------------------------------------------------------------------
// Read providers
// ---------------------------------------------------------------------------

@riverpod
Stream<List<AppUser>> usersStream(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection(FirestorePaths.users)
      .orderBy('name')
      .snapshots()
      .map((snap) => snap.docs.map(AppUser.fromFirestore).toList());
}

@riverpod
Future<AppUser> user(Ref ref, String userId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc =
      await firestore.collection(FirestorePaths.users).doc(userId).get();
  return AppUser.fromFirestore(doc);
}

// ---------------------------------------------------------------------------
// Write helpers
// ---------------------------------------------------------------------------

@riverpod
UserActions userActions(Ref ref) {
  return UserActions(ref.watch(firestoreProvider));
}

class UserActions {
  final FirebaseFirestore _firestore;
  UserActions(this._firestore);

  CollectionReference get _ref => _firestore.collection(FirestorePaths.users);

  /// Creates user doc using the Auth UID as the document ID.
  Future<void> create(AppUser user) async {
    await _ref.doc(user.id).set(user.toMap());
  }

  Future<void> update(AppUser user) async {
    await _ref.doc(user.id).update(user.toMap());
  }
}
