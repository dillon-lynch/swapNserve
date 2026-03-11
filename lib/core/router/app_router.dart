import 'package:go_router/go_router.dart';
import 'package:swap_n_serve/features/events/screens/events_list_screen.dart';
import 'package:swap_n_serve/features/events/screens/event_detail_screen.dart';
import 'package:swap_n_serve/features/inventory/screens/inventory_gallery_screen.dart';
import 'package:swap_n_serve/features/inventory/screens/inventory_item_detail_screen.dart';
import 'package:swap_n_serve/features/locations/screens/locations_screen.dart';
import 'package:swap_n_serve/features/analytics/screens/event_analytics_screen.dart';
import 'package:swap_n_serve/features/analytics/screens/location_analytics_screen.dart';
import 'package:swap_n_serve/features/chat/screens/event_chat_screen.dart';
import 'package:swap_n_serve/features/users/screens/users_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/events',
  routes: [
    GoRoute(
      path: '/events',
      builder: (context, state) => const EventsListScreen(),
      routes: [
        GoRoute(
          path: ':eventId',
          builder: (context, state) =>
              EventDetailScreen(eventId: state.pathParameters['eventId']!),
          routes: [
            GoRoute(
              path: 'chat',
              builder: (context, state) =>
                  EventChatScreen(eventId: state.pathParameters['eventId']!),
            ),
            GoRoute(
              path: 'analytics',
              builder: (context, state) => EventAnalyticsScreen(
                eventId: state.pathParameters['eventId']!,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/inventory',
      builder: (context, state) => const InventoryGalleryScreen(),
      routes: [
        GoRoute(
          path: ':itemId',
          builder: (context, state) => InventoryItemDetailScreen(
            itemId: state.pathParameters['itemId']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/locations',
      builder: (context, state) => const LocationsScreen(),
      routes: [
        GoRoute(
          path: ':locationId/analytics',
          builder: (context, state) => LocationAnalyticsScreen(
            locationId: state.pathParameters['locationId']!,
          ),
        ),
      ],
    ),
    GoRoute(path: '/users', builder: (context, state) => const UsersScreen()),
  ],
);
