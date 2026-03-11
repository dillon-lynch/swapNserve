// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$eventRepositoryHash() => r'c7f67dd334df73175edda838bec79ca1d5946276';

/// See also [eventRepository].
@ProviderFor(eventRepository)
final eventRepositoryProvider = AutoDisposeProvider<EventRepository>.internal(
  eventRepository,
  name: r'eventRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventRepositoryRef = AutoDisposeProviderRef<EventRepository>;
String _$eventsStreamHash() => r'130b597a2d428d27c9c098be6c2bbf4a4358f5f7';

/// See also [eventsStream].
@ProviderFor(eventsStream)
final eventsStreamProvider = AutoDisposeStreamProvider<List<Event>>.internal(
  eventsStream,
  name: r'eventsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$eventsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EventsStreamRef = AutoDisposeStreamProviderRef<List<Event>>;
String _$eventHash() => r'7a3d8a10571dcc29db6ca15fd40f83067defd3dc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [event].
@ProviderFor(event)
const eventProvider = EventFamily();

/// See also [event].
class EventFamily extends Family<AsyncValue<Event>> {
  /// See also [event].
  const EventFamily();

  /// See also [event].
  EventProvider call(String eventId) {
    return EventProvider(eventId);
  }

  @override
  EventProvider getProviderOverride(covariant EventProvider provider) {
    return call(provider.eventId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventProvider';
}

/// See also [event].
class EventProvider extends AutoDisposeFutureProvider<Event> {
  /// See also [event].
  EventProvider(String eventId)
    : this._internal(
        (ref) => event(ref as EventRef, eventId),
        from: eventProvider,
        name: r'eventProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventHash,
        dependencies: EventFamily._dependencies,
        allTransitiveDependencies: EventFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(FutureOr<Event> Function(EventRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: EventProvider._internal(
        (ref) => create(ref as EventRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Event> createElement() {
    return _EventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventRef on AutoDisposeFutureProviderRef<Event> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventProviderElement extends AutoDisposeFutureProviderElement<Event>
    with EventRef {
  _EventProviderElement(super.provider);

  @override
  String get eventId => (origin as EventProvider).eventId;
}

String _$eventsForLocationHash() => r'1634f0a42ebe88c13d4112f99ad12b78158c1ae8';

/// See also [eventsForLocation].
@ProviderFor(eventsForLocation)
const eventsForLocationProvider = EventsForLocationFamily();

/// See also [eventsForLocation].
class EventsForLocationFamily extends Family<AsyncValue<List<Event>>> {
  /// See also [eventsForLocation].
  const EventsForLocationFamily();

  /// See also [eventsForLocation].
  EventsForLocationProvider call(String locationId) {
    return EventsForLocationProvider(locationId);
  }

  @override
  EventsForLocationProvider getProviderOverride(
    covariant EventsForLocationProvider provider,
  ) {
    return call(provider.locationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'eventsForLocationProvider';
}

/// See also [eventsForLocation].
class EventsForLocationProvider extends AutoDisposeFutureProvider<List<Event>> {
  /// See also [eventsForLocation].
  EventsForLocationProvider(String locationId)
    : this._internal(
        (ref) => eventsForLocation(ref as EventsForLocationRef, locationId),
        from: eventsForLocationProvider,
        name: r'eventsForLocationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventsForLocationHash,
        dependencies: EventsForLocationFamily._dependencies,
        allTransitiveDependencies:
            EventsForLocationFamily._allTransitiveDependencies,
        locationId: locationId,
      );

  EventsForLocationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.locationId,
  }) : super.internal();

  final String locationId;

  @override
  Override overrideWith(
    FutureOr<List<Event>> Function(EventsForLocationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventsForLocationProvider._internal(
        (ref) => create(ref as EventsForLocationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        locationId: locationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Event>> createElement() {
    return _EventsForLocationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsForLocationProvider && other.locationId == locationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, locationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EventsForLocationRef on AutoDisposeFutureProviderRef<List<Event>> {
  /// The parameter `locationId` of this provider.
  String get locationId;
}

class _EventsForLocationProviderElement
    extends AutoDisposeFutureProviderElement<List<Event>>
    with EventsForLocationRef {
  _EventsForLocationProviderElement(super.provider);

  @override
  String get locationId => (origin as EventsForLocationProvider).locationId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
