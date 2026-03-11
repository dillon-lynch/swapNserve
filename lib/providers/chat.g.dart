// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatRepositoryHash() => r'b2dded8a62d40083dcd54e15edbb2e814d700b1c';

/// See also [chatRepository].
@ProviderFor(chatRepository)
final chatRepositoryProvider = AutoDisposeProvider<ChatRepository>.internal(
  chatRepository,
  name: r'chatRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatRepositoryRef = AutoDisposeProviderRef<ChatRepository>;
String _$chatMessagesHash() => r'9f03f80eab38c41cf2f7b45f2440ffd732cf2fcb';

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

/// Real-time stream of messages for [eventId], ordered oldest-first.
///
/// Copied from [chatMessages].
@ProviderFor(chatMessages)
const chatMessagesProvider = ChatMessagesFamily();

/// Real-time stream of messages for [eventId], ordered oldest-first.
///
/// Copied from [chatMessages].
class ChatMessagesFamily extends Family<AsyncValue<List<ChatMessage>>> {
  /// Real-time stream of messages for [eventId], ordered oldest-first.
  ///
  /// Copied from [chatMessages].
  const ChatMessagesFamily();

  /// Real-time stream of messages for [eventId], ordered oldest-first.
  ///
  /// Copied from [chatMessages].
  ChatMessagesProvider call(String eventId) {
    return ChatMessagesProvider(eventId);
  }

  @override
  ChatMessagesProvider getProviderOverride(
    covariant ChatMessagesProvider provider,
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
  String? get name => r'chatMessagesProvider';
}

/// Real-time stream of messages for [eventId], ordered oldest-first.
///
/// Copied from [chatMessages].
class ChatMessagesProvider
    extends AutoDisposeStreamProvider<List<ChatMessage>> {
  /// Real-time stream of messages for [eventId], ordered oldest-first.
  ///
  /// Copied from [chatMessages].
  ChatMessagesProvider(String eventId)
    : this._internal(
        (ref) => chatMessages(ref as ChatMessagesRef, eventId),
        from: chatMessagesProvider,
        name: r'chatMessagesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$chatMessagesHash,
        dependencies: ChatMessagesFamily._dependencies,
        allTransitiveDependencies:
            ChatMessagesFamily._allTransitiveDependencies,
        eventId: eventId,
      );

  ChatMessagesProvider._internal(
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
    Stream<List<ChatMessage>> Function(ChatMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatMessagesProvider._internal(
        (ref) => create(ref as ChatMessagesRef),
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
  AutoDisposeStreamProviderElement<List<ChatMessage>> createElement() {
    return _ChatMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesProvider && other.eventId == eventId;
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
mixin ChatMessagesRef on AutoDisposeStreamProviderRef<List<ChatMessage>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _ChatMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<ChatMessage>>
    with ChatMessagesRef {
  _ChatMessagesProviderElement(super.provider);

  @override
  String get eventId => (origin as ChatMessagesProvider).eventId;
}

String _$currentUserIdHash() => r'76e427c982d65d337a61b23ca95c4af52f98eeb9';

/// The current Firebase Auth user ID, or null if not signed in.
///
/// Copied from [currentUserId].
@ProviderFor(currentUserId)
final currentUserIdProvider = AutoDisposeProvider<String?>.internal(
  currentUserId,
  name: r'currentUserIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserIdRef = AutoDisposeProviderRef<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
