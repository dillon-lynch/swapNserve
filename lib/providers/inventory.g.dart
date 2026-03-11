// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$inventoryStreamHash() => r'77628a947571158abd84b960dbfb497bfd3bca87';

/// See also [inventoryStream].
@ProviderFor(inventoryStream)
final inventoryStreamProvider =
    AutoDisposeStreamProvider<List<InventoryItem>>.internal(
      inventoryStream,
      name: r'inventoryStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inventoryStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryStreamRef = AutoDisposeStreamProviderRef<List<InventoryItem>>;
String _$inventoryItemHash() => r'e129c54815c566c23759cb5de71fcf6739cd70c3';

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

/// See also [inventoryItem].
@ProviderFor(inventoryItem)
const inventoryItemProvider = InventoryItemFamily();

/// See also [inventoryItem].
class InventoryItemFamily extends Family<AsyncValue<InventoryItem>> {
  /// See also [inventoryItem].
  const InventoryItemFamily();

  /// See also [inventoryItem].
  InventoryItemProvider call(String itemId) {
    return InventoryItemProvider(itemId);
  }

  @override
  InventoryItemProvider getProviderOverride(
    covariant InventoryItemProvider provider,
  ) {
    return call(provider.itemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'inventoryItemProvider';
}

/// See also [inventoryItem].
class InventoryItemProvider extends AutoDisposeFutureProvider<InventoryItem> {
  /// See also [inventoryItem].
  InventoryItemProvider(String itemId)
    : this._internal(
        (ref) => inventoryItem(ref as InventoryItemRef, itemId),
        from: inventoryItemProvider,
        name: r'inventoryItemProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$inventoryItemHash,
        dependencies: InventoryItemFamily._dependencies,
        allTransitiveDependencies:
            InventoryItemFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  InventoryItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<InventoryItem> Function(InventoryItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InventoryItemProvider._internal(
        (ref) => create(ref as InventoryItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<InventoryItem> createElement() {
    return _InventoryItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InventoryItemProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InventoryItemRef on AutoDisposeFutureProviderRef<InventoryItem> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _InventoryItemProviderElement
    extends AutoDisposeFutureProviderElement<InventoryItem>
    with InventoryItemRef {
  _InventoryItemProviderElement(super.provider);

  @override
  String get itemId => (origin as InventoryItemProvider).itemId;
}

String _$inventoryByCategoryHash() =>
    r'ae2754c41263bf89cd4c1a5b9621d6243f157d21';

/// See also [inventoryByCategory].
@ProviderFor(inventoryByCategory)
const inventoryByCategoryProvider = InventoryByCategoryFamily();

/// See also [inventoryByCategory].
class InventoryByCategoryFamily
    extends Family<AsyncValue<List<InventoryItem>>> {
  /// See also [inventoryByCategory].
  const InventoryByCategoryFamily();

  /// See also [inventoryByCategory].
  InventoryByCategoryProvider call(String category) {
    return InventoryByCategoryProvider(category);
  }

  @override
  InventoryByCategoryProvider getProviderOverride(
    covariant InventoryByCategoryProvider provider,
  ) {
    return call(provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'inventoryByCategoryProvider';
}

/// See also [inventoryByCategory].
class InventoryByCategoryProvider
    extends AutoDisposeStreamProvider<List<InventoryItem>> {
  /// See also [inventoryByCategory].
  InventoryByCategoryProvider(String category)
    : this._internal(
        (ref) => inventoryByCategory(ref as InventoryByCategoryRef, category),
        from: inventoryByCategoryProvider,
        name: r'inventoryByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$inventoryByCategoryHash,
        dependencies: InventoryByCategoryFamily._dependencies,
        allTransitiveDependencies:
            InventoryByCategoryFamily._allTransitiveDependencies,
        category: category,
      );

  InventoryByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    Stream<List<InventoryItem>> Function(InventoryByCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: InventoryByCategoryProvider._internal(
        (ref) => create(ref as InventoryByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<InventoryItem>> createElement() {
    return _InventoryByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InventoryByCategoryProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InventoryByCategoryRef
    on AutoDisposeStreamProviderRef<List<InventoryItem>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _InventoryByCategoryProviderElement
    extends AutoDisposeStreamProviderElement<List<InventoryItem>>
    with InventoryByCategoryRef {
  _InventoryByCategoryProviderElement(super.provider);

  @override
  String get category => (origin as InventoryByCategoryProvider).category;
}

String _$inventoryActionsHash() => r'4a6a14bca7807f40f0091b0dd97e6c77de566120';

/// See also [inventoryActions].
@ProviderFor(inventoryActions)
final inventoryActionsProvider = AutoDisposeProvider<InventoryActions>.internal(
  inventoryActions,
  name: r'inventoryActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$inventoryActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InventoryActionsRef = AutoDisposeProviderRef<InventoryActions>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
