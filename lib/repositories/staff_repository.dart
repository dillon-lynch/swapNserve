import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swap_n_serve/core/constants/firestore_paths.dart';
import 'package:swap_n_serve/models/app_user.dart';

class StaffRepository {
  final FirebaseFirestore _firestore;

  StaffRepository(this._firestore);

  CollectionReference get _ref => _firestore.collection(FirestorePaths.users);

  Stream<List<AppUser>> watchAll() {
    return _ref
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs.map(AppUser.fromFirestore).toList());
  }

  Future<AppUser> get(String userId) async {
    final doc = await _ref.doc(userId).get();
    return AppUser.fromFirestore(doc);
  }

  Future<void> create(AppUser user) async {
    await _ref.doc(user.id).set(user.toMap());
  }

  Future<void> update(AppUser user) async {
    await _ref.doc(user.id).update(user.toMap());
  }
}
