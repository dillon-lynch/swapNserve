// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffRepositoryHash() => r'fd0c05a9740784b297979c6436a0d79940d2b08f';

/// See also [staffRepository].
@ProviderFor(staffRepository)
final staffRepositoryProvider = AutoDisposeProvider<StaffRepository>.internal(
  staffRepository,
  name: r'staffRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$staffRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StaffRepositoryRef = AutoDisposeProviderRef<StaffRepository>;
String _$usersStreamHash() => r'c6e897bc20d25ac8dbf37884076ab5063ccdded8';

/// See also [usersStream].
@ProviderFor(usersStream)
final usersStreamProvider = AutoDisposeStreamProvider<List<AppUser>>.internal(
  usersStream,
  name: r'usersStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$usersStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UsersStreamRef = AutoDisposeStreamProviderRef<List<AppUser>>;
String _$userHash() => r'9fc03465c97d4561dcbedb87541e3cd719de6b1b';

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

/// See also [user].
@ProviderFor(user)
const userProvider = UserFamily();

/// See also [user].
class UserFamily extends Family<AsyncValue<AppUser>> {
  /// See also [user].
  const UserFamily();

  /// See also [user].
  UserProvider call(String userId) {
    return UserProvider(userId);
  }

  @override
  UserProvider getProviderOverride(covariant UserProvider provider) {
    return call(provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProvider';
}

/// See also [user].
class UserProvider extends AutoDisposeFutureProvider<AppUser> {
  /// See also [user].
  UserProvider(String userId)
    : this._internal(
        (ref) => user(ref as UserRef, userId),
        from: userProvider,
        name: r'userProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userHash,
        dependencies: UserFamily._dependencies,
        allTransitiveDependencies: UserFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(FutureOr<AppUser> Function(UserRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        (ref) => create(ref as UserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AppUser> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserRef on AutoDisposeFutureProviderRef<AppUser> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProviderElement extends AutoDisposeFutureProviderElement<AppUser>
    with UserRef {
  _UserProviderElement(super.provider);

  @override
  String get userId => (origin as UserProvider).userId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
