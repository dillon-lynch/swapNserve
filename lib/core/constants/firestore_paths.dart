class FirestorePaths {
  static const String events = 'events';
  static const String locations = 'locations';
  static const String inventory = 'inventory';
  static const String transactions = 'transactions';
  static const String staff = 'staff';

  static String eventMessages(String eventId) => 'events/$eventId/messages';
}
