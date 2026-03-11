import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:swap_n_serve/models/event.dart';
import 'package:swap_n_serve/providers/firebase.dart';
import 'package:swap_n_serve/repositories/event_repository.dart';

part 'event.g.dart';

@riverpod
EventRepository eventRepository(Ref ref) {
  return EventRepository(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<Event>> eventsStream(Ref ref) {
  return ref.watch(eventRepositoryProvider).watchAll();
}

@riverpod
Future<Event> event(Ref ref, String eventId) {
  return ref.watch(eventRepositoryProvider).get(eventId);
}

@riverpod
Future<List<Event>> eventsForLocation(Ref ref, String locationId) {
  return ref.watch(eventRepositoryProvider).getForLocation(locationId);
}
