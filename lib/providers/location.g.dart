// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationsStreamHash() => r'a7877c789caaf425a15cb419d6acfbfcc4d0ef1b';

/// See also [locationsStream].
@ProviderFor(locationsStream)
final locationsStreamProvider =
    AutoDisposeStreamProvider<List<Location>>.internal(
      locationsStream,
      name: r'locationsStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$locationsStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationsStreamRef = AutoDisposeStreamProviderRef<List<Location>>;
String _$locationHash() => r'0016a0c861ed6faa3db4b242f65d24a16df279af';

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

/// See also [location].
@ProviderFor(location)
const locationProvider = LocationFamily();

/// See also [location].
class LocationFamily extends Family<AsyncValue<Location>> {
  /// See also [location].
  const LocationFamily();

  /// See also [location].
  LocationProvider call(String locationId) {
    return LocationProvider(locationId);
  }

  @override
  LocationProvider getProviderOverride(covariant LocationProvider provider) {
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
  String? get name => r'locationProvider';
}

/// See also [location].
class LocationProvider extends AutoDisposeFutureProvider<Location> {
  /// See also [location].
  LocationProvider(String locationId)
    : this._internal(
        (ref) => location(ref as LocationRef, locationId),
        from: locationProvider,
        name: r'locationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$locationHash,
        dependencies: LocationFamily._dependencies,
        allTransitiveDependencies: LocationFamily._allTransitiveDependencies,
        locationId: locationId,
      );

  LocationProvider._internal(
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
    FutureOr<Location> Function(LocationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LocationProvider._internal(
        (ref) => create(ref as LocationRef),
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
  AutoDisposeFutureProviderElement<Location> createElement() {
    return _LocationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocationProvider && other.locationId == locationId;
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
mixin LocationRef on AutoDisposeFutureProviderRef<Location> {
  /// The parameter `locationId` of this provider.
  String get locationId;
}

class _LocationProviderElement
    extends AutoDisposeFutureProviderElement<Location>
    with LocationRef {
  _LocationProviderElement(super.provider);

  @override
  String get locationId => (origin as LocationProvider).locationId;
}

String _$locationActionsHash() => r'de49f169bd38aa2a566b3473fe8d4cf293b1e89b';

/// See also [locationActions].
@ProviderFor(locationActions)
final locationActionsProvider = AutoDisposeProvider<LocationActions>.internal(
  locationActions,
  name: r'locationActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationActionsRef = AutoDisposeProviderRef<LocationActions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
