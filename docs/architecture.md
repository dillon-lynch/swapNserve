# Swap N Serve — Architecture

## 1. Firestore Schema

```
├── events/{eventId}
│     ├── title: string
│     ├── startDate: timestamp
│     ├── endDate: timestamp
│     ├── locationId: string (ref → locations)
│     ├── assignedStaff: string[] (staff UIDs)
│     ├── notes: string
│     ├── createdAt: timestamp
│     └── messages/{messageId}          ← subcollection (event chat)
│           ├── senderId: string
│           ├── senderName: string
│           ├── text: string
│           └── sentAt: timestamp
│
├── locations/{locationId}
│     ├── name: string
│     ├── address: string
│     ├── lat: number
│     ├── lng: number
│     └── createdAt: timestamp
│
├── inventory/{itemId}
│     ├── name: string
│     ├── category: string
│     ├── imageUrl: string
│     └── createdAt: timestamp
│     (totalStock is DERIVED from transactions — never stored here)
│
├── transactions/{transactionId}
│     ├── itemId: string (ref → inventory)
│     ├── type: "intake" | "distributed"
│     ├── quantity: number (always positive)
│     ├── eventId: string? (nullable — null means outside an event)
│     ├── performedBy: string (staff UID)
│     ├── notes: string
│     └── createdAt: timestamp
│
└── staff/{staffId}                     ← staffId = Firebase Auth UID
      ├── name: string
      ├── email: string
      ├── role: "admin" | "volunteer"
      ├── avatarUrl: string
      └── createdAt: timestamp
```

### Why this shape?

| Decision                                 | Rationale                                                                       |
| ---------------------------------------- | ------------------------------------------------------------------------------- |
| Inventory is a flat top-level collection | Global pool — not scoped to events                                              |
| Transactions are top-level               | Can query by itemId, eventId, or neither                                        |
| totalStock is derived                    | `SUM(intake.qty) - SUM(distributed.qty)` — single source of truth               |
| Chat is a subcollection of events        | Scoped naturally, Firestore real-time listeners are efficient on subcollections |
| assignedStaff is an array on the event   | Simple; `arrayContains` queries let staff find their events                     |

### Key Queries

```
// All transactions for an inventory item
transactions WHERE itemId == X ORDER BY createdAt DESC

// All transactions during an event
transactions WHERE eventId == X ORDER BY createdAt DESC

// Events at a location
events WHERE locationId == X

// Events for a staff member
events WHERE assignedStaff arrayContains staffId

// Global stock for one item
transactions WHERE itemId == X → derive total

// Chat messages (real-time)
events/{eventId}/messages ORDER BY sentAt ASC
```

---

## 2. Flutter Architecture

**Pattern:** Feature-first + layered inside each feature.

```
lib/
├── main.dart
├── app.dart                        ← MaterialApp, router, theme
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart         ← GoRouter config
│   ├── constants/
│   │   └── firestore_paths.dart
│   └── extensions/
│       └── date_extensions.dart
│
├── models/                          ← shared data classes
│   ├── event_model.dart
│   ├── location_model.dart
│   ├── inventory_item_model.dart
│   ├── transaction_model.dart
│   ├── staff_model.dart
│   └── chat_message_model.dart
│
├── repositories/                    ← Firestore CRUD
│   ├── event_repository.dart
│   ├── location_repository.dart
│   ├── inventory_repository.dart
│   ├── transaction_repository.dart
│   ├── staff_repository.dart
│   └── chat_repository.dart
│
├── providers/                       ← Riverpod providers
│   ├── firebase_providers.dart
│   ├── event_providers.dart
│   ├── location_providers.dart
│   ├── inventory_providers.dart
│   ├── transaction_providers.dart
│   ├── staff_providers.dart
│   └── chat_providers.dart
│
└── features/
    ├── events/
    │   ├── screens/
    │   │   ├── events_list_screen.dart
    │   │   └── event_detail_screen.dart
    │   └── widgets/
    │       ├── event_card.dart
    │       └── event_form.dart
    │
    ├── inventory/
    │   ├── screens/
    │   │   ├── inventory_gallery_screen.dart
    │   │   └── inventory_item_detail_screen.dart
    │   └── widgets/
    │       ├── inventory_grid_tile.dart
    │       └── transaction_form.dart
    │
    ├── locations/
    │   ├── screens/
    │   │   └── locations_screen.dart
    │   └── widgets/
    │       └── location_card.dart
    │
    ├── analytics/
    │   ├── screens/
    │   │   ├── event_analytics_screen.dart
    │   │   └── location_analytics_screen.dart
    │   └── widgets/
    │       └── stat_card.dart
    │
    ├── chat/
    │   ├── screens/
    │   │   └── event_chat_screen.dart
    │   └── widgets/
    │       └── chat_bubble.dart
    │
    └── staff/
        ├── screens/
        │   └── staff_screen.dart
        └── widgets/
            └── staff_avatar.dart
```

---

## 3. Riverpod Providers

```dart
// --- Firebase instances ---
final firestoreProvider = Provider((_) => FirebaseFirestore.instance);
final authProvider      = Provider((_) => FirebaseAuth.instance);
final storageProvider   = Provider((_) => FirebaseStorage.instance);

// --- Repositories (injected with Firestore) ---
final eventRepoProvider       = Provider((ref) => EventRepository(ref.watch(firestoreProvider)));
final locationRepoProvider    = Provider((ref) => LocationRepository(ref.watch(firestoreProvider)));
final inventoryRepoProvider   = Provider((ref) => InventoryRepository(ref.watch(firestoreProvider)));
final transactionRepoProvider = Provider((ref) => TransactionRepository(ref.watch(firestoreProvider)));
final staffRepoProvider       = Provider((ref) => StaffRepository(ref.watch(firestoreProvider)));
final chatRepoProvider        = Provider((ref) => ChatRepository(ref.watch(firestoreProvider)));

// --- Streams / Async data ---
final eventsStreamProvider = StreamProvider((ref) =>
    ref.watch(eventRepoProvider).watchAll());

final inventoryStreamProvider = StreamProvider((ref) =>
    ref.watch(inventoryRepoProvider).watchAll());

final itemStockProvider = FutureProvider.family<int, String>((ref, itemId) =>
    ref.watch(transactionRepoProvider).computeStock(itemId));

final eventTransactionsProvider = StreamProvider.family<List<TransactionModel>, String>(
    (ref, eventId) => ref.watch(transactionRepoProvider).watchByEvent(eventId));

final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>(
    (ref, eventId) => ref.watch(chatRepoProvider).watchMessages(eventId));

// --- Analytics (derived) ---
final eventAnalyticsProvider = FutureProvider.family((ref, eventId) =>
    ref.watch(transactionRepoProvider).eventDistributionTotal(eventId));

final locationAnalyticsProvider = FutureProvider.family((ref, locationId) =>
    ref.watch(eventRepoProvider).eventsForLocation(locationId));
```

---

## 4. Repository Layer

Each repository is a thin Firestore wrapper. No business logic.

```
┌────────────┐     ┌──────────────┐     ┌──────────────┐
│   Screen    │ ──► │   Provider   │ ──► │  Repository  │ ──► Firestore
└────────────┘     └──────────────┘     └──────────────┘
      ▲                                        │
      └──── StreamProvider / FutureProvider ────┘
```

### Repository signatures

```dart
class EventRepository {
  Stream<List<EventModel>> watchAll();
  Future<EventModel> getById(String id);
  Future<void> create(EventModel event);
  Future<void> update(EventModel event);
  Future<void> delete(String id);
  Future<List<EventModel>> eventsForLocation(String locationId);
}

class InventoryRepository {
  Stream<List<InventoryItemModel>> watchAll();
  Future<InventoryItemModel> getById(String id);
  Future<void> create(InventoryItemModel item);
  Future<void> update(InventoryItemModel item);
  Future<void> delete(String id);
}

class TransactionRepository {
  Stream<List<TransactionModel>> watchAll();
  Stream<List<TransactionModel>> watchByItem(String itemId);
  Stream<List<TransactionModel>> watchByEvent(String eventId);
  Future<void> create(TransactionModel txn);
  Future<int> computeStock(String itemId);        // intake - distributed
  Future<int> eventDistributionTotal(String eventId);
}

class ChatRepository {
  Stream<List<ChatMessage>> watchMessages(String eventId);
  Future<void> sendMessage(String eventId, ChatMessage msg);
}

class StaffRepository {
  Stream<List<StaffModel>> watchAll();
  Future<StaffModel> getById(String id);
  Future<void> create(StaffModel staff);
  Future<void> update(StaffModel staff);
}

class LocationRepository {
  Stream<List<LocationModel>> watchAll();
  Future<void> create(LocationModel loc);
  Future<void> update(LocationModel loc);
  Future<void> delete(String id);
}
```

---

## 5. Data Flow Diagrams

### 5a. Inventory Transaction Flow

```
Staff taps "Add Stock" or "Distribute"
         │
         ▼
  TransactionForm widget
         │
         ▼
  transactionRepoProvider.create(TransactionModel(
      itemId, type, quantity, eventId?, performedBy
  ))
         │
         ▼
  Firestore: transactions/{auto-id}
         │
  ┌──────┴──────────────────────────┐
  │  itemStockProvider(itemId)      │   ← re-derives totalStock
  │  eventTransactionsProvider(eid) │   ← updates event view
  └─────────────────────────────────┘
```

### 5b. Event Chat Flow

```
Staff opens EventDetailScreen → Chat tab
         │
         ▼
  chatMessagesProvider(eventId).stream
         │  (real-time Firestore listener)
         ▼
  ListView of ChatBubble widgets
         │
  Staff types message → chatRepoProvider.sendMessage()
         │
         ▼
  Firestore: events/{eventId}/messages/{auto-id}
         │
         ▼
  Stream emits new snapshot → UI rebuilds
```

### 5c. Analytics Flow

```
  LocationAnalyticsScreen
         │
         ▼
  locationAnalyticsProvider(locationId)
         │
         ▼
  EventRepository.eventsForLocation(locationId)
         │
         ▼
  For each event → transactionRepo.eventDistributionTotal(eventId)
         │
         ▼
  Aggregate: total distributed per location, per event
         │
         ▼
  Bar chart / summary cards
```

### 5d. Staff Assignment + Notification Flow

```
Admin selects staff on EventForm
         │
         ▼
  eventRepo.update(event.copyWith(assignedStaff: [...]))
         │
         ▼
  Cloud Function (Firestore trigger on events write):
    → detects new staff IDs in assignedStaff
    → looks up email from staff/{id}
    → sends email via SendGrid / Firebase Extensions
```

---

## 6. Key Dependencies (pubspec.yaml)

```yaml
dependencies:
  flutter_riverpod: ^2.0.0
  firebase_core: ^3.0.0
  cloud_firestore: ^5.0.0
  firebase_auth: ^5.0.0
  firebase_storage: ^12.0.0
  go_router: ^14.0.0
  cached_network_image: ^3.3.0
  image_picker: ^1.0.0
  intl: ^0.19.0
```

---

## 7. Summary

| Layer            | Responsibility                                        |
| ---------------- | ----------------------------------------------------- |
| **Models**       | Immutable data classes with `fromFirestore` / `toMap` |
| **Repositories** | Firestore reads/writes, stream wrappers               |
| **Providers**    | Riverpod — glue repos to UI, caching, families        |
| **Features**     | Screens + widgets, consume providers                  |
| **Core**         | Theme, routing, constants                             |

The architecture is intentionally flat — no unnecessary abstractions, no use-case classes, no BLoC. Riverpod providers _are_ the state management and the dependency injection.
