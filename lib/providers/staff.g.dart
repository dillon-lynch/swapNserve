// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffStreamHash() => r'084b9113e030bde372b561b7e0340bbe504e9930';

/// See also [staffStream].
@ProviderFor(staffStream)
final staffStreamProvider = AutoDisposeStreamProvider<List<Staff>>.internal(
  staffStream,
  name: r'staffStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StaffStreamRef = AutoDisposeStreamProviderRef<List<Staff>>;
String _$staffMemberHash() => r'7d32308fa6cbd7c7341f6724258e13f495b08af0';

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

/// See also [staffMember].
@ProviderFor(staffMember)
const staffMemberProvider = StaffMemberFamily();

/// See also [staffMember].
class StaffMemberFamily extends Family<AsyncValue<Staff>> {
  /// See also [staffMember].
  const StaffMemberFamily();

  /// See also [staffMember].
  StaffMemberProvider call(String staffId) {
    return StaffMemberProvider(staffId);
  }

  @override
  StaffMemberProvider getProviderOverride(
    covariant StaffMemberProvider provider,
  ) {
    return call(provider.staffId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'staffMemberProvider';
}

/// See also [staffMember].
class StaffMemberProvider extends AutoDisposeFutureProvider<Staff> {
  /// See also [staffMember].
  StaffMemberProvider(String staffId)
    : this._internal(
        (ref) => staffMember(ref as StaffMemberRef, staffId),
        from: staffMemberProvider,
        name: r'staffMemberProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$staffMemberHash,
        dependencies: StaffMemberFamily._dependencies,
        allTransitiveDependencies: StaffMemberFamily._allTransitiveDependencies,
        staffId: staffId,
      );

  StaffMemberProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.staffId,
  }) : super.internal();

  final String staffId;

  @override
  Override overrideWith(
    FutureOr<Staff> Function(StaffMemberRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StaffMemberProvider._internal(
        (ref) => create(ref as StaffMemberRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        staffId: staffId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Staff> createElement() {
    return _StaffMemberProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffMemberProvider && other.staffId == staffId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, staffId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StaffMemberRef on AutoDisposeFutureProviderRef<Staff> {
  /// The parameter `staffId` of this provider.
  String get staffId;
}

class _StaffMemberProviderElement
    extends AutoDisposeFutureProviderElement<Staff>
    with StaffMemberRef {
  _StaffMemberProviderElement(super.provider);

  @override
  String get staffId => (origin as StaffMemberProvider).staffId;
}

String _$staffActionsHash() => r'159d4e11988deb0ad8ce4a8e01012361edf70765';

/// See also [staffActions].
@ProviderFor(staffActions)
final staffActionsProvider = AutoDisposeProvider<StaffActions>.internal(
  staffActions,
  name: r'staffActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StaffActionsRef = AutoDisposeProviderRef<StaffActions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
