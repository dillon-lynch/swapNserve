import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/app_user.dart';
import 'package:swap_n_serve/providers/firebase.dart';
import 'package:swap_n_serve/repositories/staff_repository.dart';

part 'user.g.dart';

@riverpod
StaffRepository staffRepository(Ref ref) {
  return StaffRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<AppUser>> usersStream(Ref ref) {
  return ref.watch(staffRepositoryProvider).watchAll();
}

@riverpod
Future<AppUser> user(Ref ref, String userId) {
  return ref.watch(staffRepositoryProvider).get(userId);
}
