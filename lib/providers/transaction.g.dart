// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemTransactionsHash() => r'7423ccaa84e91e7986f49b2589ce35d9e08d95a5';

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

/// See also [itemTransactions].
@ProviderFor(itemTransactions)
const itemTransactionsProvider = ItemTransactionsFamily();

/// See also [itemTransactions].
class ItemTransactionsFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [itemTransactions].
  const ItemTransactionsFamily();

  /// See also [itemTransactions].
  ItemTransactionsProvider call(String itemId) {
    return ItemTransactionsProvider(itemId);
  }

  @override
  ItemTransactionsProvider getProviderOverride(
    covariant ItemTransactionsProvider provider,
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
  String? get name => r'itemTransactionsProvider';
}

/// See also [itemTransactions].
class ItemTransactionsProvider
    extends AutoDisposeStreamProvider<List<Transaction>> {
  /// See also [itemTransactions].
  ItemTransactionsProvider(String itemId)
    : this._internal(
        (ref) => itemTransactions(ref as ItemTransactionsRef, itemId),
        from: itemTransactionsProvider,
        name: r'itemTransactionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$itemTransactionsHash,
        dependencies: ItemTransactionsFamily._dependencies,
        allTransitiveDependencies:
            ItemTransactionsFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  ItemTransactionsProvider._internal(
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
    Stream<List<Transaction>> Function(ItemTransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemTransactionsProvider._internal(
        (ref) => create(ref as ItemTransactionsRef),
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
  AutoDisposeStreamProviderElement<List<Transaction>> createElement() {
    return _ItemTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemTransactionsProvider && other.itemId == itemId;
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
mixin ItemTransactionsRef on AutoDisposeStreamProviderRef<List<Transaction>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemTransactionsProviderElement
    extends AutoDisposeStreamProviderElement<List<Transaction>>
    with ItemTransactionsRef {
  _ItemTransactionsProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemTransactionsProvider).itemId;
}

String _$eventTransactionsHash() => r'55cc6ae587bcd0e776428c6acbb016e09925c200';

/// See also [eventTransactions].
@ProviderFor(eventTransactions)
const eventTransactionsProvider = EventTransactionsFamily();

/// See also [eventTransactions].
class EventTransactionsFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [eventTransactions].
  const EventTransactionsFamily();

  /// See also [eventTransactions].
  EventTransactionsProvider call(String eventId) {
    return EventTransactionsProvider(eventId);
  }

  @override
  EventTransactionsProvider getProviderOverride(
    covariant EventTransactionsProvider provider,
  ) {
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
  String? get name => r'eventTransactionsProvider';
}

/// See also [eventTransactions].
class EventTransactionsProvider
    extends AutoDisposeStreamProvider<List<Transaction>> {
  /// See also [eventTransactions].
  EventTransactionsProvider(String eventId)
    : this._internal(
        (ref) => eventTransactions(ref as EventTransactionsRef, eventId),
        from: eventTransactionsProvider,
        name: r'eventTransactionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventTransactionsHash,
        dependencies: EventTransactionsFamily._dependencies,
        allTransitiveDependencies:
            EventTransactionsFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventTransactionsProvider._internal(
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
  Override overrideWith(
    Stream<List<Transaction>> Function(EventTransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventTransactionsProvider._internal(
        (ref) => create(ref as EventTransactionsRef),
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
  AutoDisposeStreamProviderElement<List<Transaction>> createElement() {
    return _EventTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventTransactionsProvider && other.eventId == eventId;
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
mixin EventTransactionsRef on AutoDisposeStreamProviderRef<List<Transaction>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventTransactionsProviderElement
    extends AutoDisposeStreamProviderElement<List<Transaction>>
    with EventTransactionsRef {
  _EventTransactionsProviderElement(super.provider);

  @override
  String get eventId => (origin as EventTransactionsProvider).eventId;
}

String _$itemStockHash() => r'858292a8a43cb2819346a03b5064b05b37025a72';

/// See also [itemStock].
@ProviderFor(itemStock)
const itemStockProvider = ItemStockFamily();

/// See also [itemStock].
class ItemStockFamily extends Family<AsyncValue<int>> {
  /// See also [itemStock].
  const ItemStockFamily();

  /// See also [itemStock].
  ItemStockProvider call(String itemId) {
    return ItemStockProvider(itemId);
  }

  @override
  ItemStockProvider getProviderOverride(covariant ItemStockProvider provider) {
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
  String? get name => r'itemStockProvider';
}

/// See also [itemStock].
class ItemStockProvider extends AutoDisposeFutureProvider<int> {
  /// See also [itemStock].
  ItemStockProvider(String itemId)
    : this._internal(
        (ref) => itemStock(ref as ItemStockRef, itemId),
        from: itemStockProvider,
        name: r'itemStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$itemStockHash,
        dependencies: ItemStockFamily._dependencies,
        allTransitiveDependencies: ItemStockFamily._allTransitiveDependencies,
        itemId: itemId,
      );

  ItemStockProvider._internal(
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
  Override overrideWith(FutureOr<int> Function(ItemStockRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ItemStockProvider._internal(
        (ref) => create(ref as ItemStockRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _ItemStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemStockProvider && other.itemId == itemId;
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
mixin ItemStockRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemStockProviderElement extends AutoDisposeFutureProviderElement<int>
    with ItemStockRef {
  _ItemStockProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemStockProvider).itemId;
}

String _$eventDistributionTotalHash() =>
    r'ea4747fc9c70c890d01d857bfdbb138e83dc04d7';

/// See also [eventDistributionTotal].
@ProviderFor(eventDistributionTotal)
const eventDistributionTotalProvider = EventDistributionTotalFamily();

/// See also [eventDistributionTotal].
class EventDistributionTotalFamily extends Family<AsyncValue<int>> {
  /// See also [eventDistributionTotal].
  const EventDistributionTotalFamily();

  /// See also [eventDistributionTotal].
  EventDistributionTotalProvider call(String eventId) {
    return EventDistributionTotalProvider(eventId);
  }

  @override
  EventDistributionTotalProvider getProviderOverride(
    covariant EventDistributionTotalProvider provider,
  ) {
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
  String? get name => r'eventDistributionTotalProvider';
}

/// See also [eventDistributionTotal].
class EventDistributionTotalProvider extends AutoDisposeFutureProvider<int> {
  /// See also [eventDistributionTotal].
  EventDistributionTotalProvider(String eventId)
    : this._internal(
        (ref) =>
            eventDistributionTotal(ref as EventDistributionTotalRef, eventId),
        from: eventDistributionTotalProvider,
        name: r'eventDistributionTotalProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$eventDistributionTotalHash,
        dependencies: EventDistributionTotalFamily._dependencies,
        allTransitiveDependencies:
            EventDistributionTotalFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  EventDistributionTotalProvider._internal(
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
  Override overrideWith(
    FutureOr<int> Function(EventDistributionTotalRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EventDistributionTotalProvider._internal(
        (ref) => create(ref as EventDistributionTotalRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _EventDistributionTotalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDistributionTotalProvider && other.eventId == eventId;
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
mixin EventDistributionTotalRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _EventDistributionTotalProviderElement
    extends AutoDisposeFutureProviderElement<int>
    with EventDistributionTotalRef {
  _EventDistributionTotalProviderElement(super.provider);

  @override
  String get eventId => (origin as EventDistributionTotalProvider).eventId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
