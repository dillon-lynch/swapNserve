// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationRepositoryHash() =>
    r'52cfb1c4b1f5db06a746de9cf2d98258be12ec7a';

/// See also [locationRepository].
@ProviderFor(locationRepository)
final locationRepositoryProvider =
    AutoDisposeProvider<LocationRepository>.internal(
      locationRepository,
      name: r'locationRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$locationRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationRepositoryRef = AutoDisposeProviderRef<LocationRepository>;
String _$locationsStreamHash() => r'fc256f5a48940840391468097ad869042c000ac7';

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
String _$locationHash() => r'eef9d5275894a71f5f176b4d90bc88a7e11e4225';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
