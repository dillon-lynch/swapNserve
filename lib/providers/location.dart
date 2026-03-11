import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/location.dart';
import 'package:swap_n_serve/providers/firebase.dart';
import 'package:swap_n_serve/repositories/location_repository.dart';

part 'location.g.dart';

@riverpod
LocationRepository locationRepository(Ref ref) {
  return LocationRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<Location>> locationsStream(Ref ref) {
  return ref.watch(locationRepositoryProvider).watchAll();
}

@riverpod
Future<Location> location(Ref ref, String locationId) {
  return ref.watch(locationRepositoryProvider).get(locationId);
}
