import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get formatted => DateFormat.yMMMd().format(this);
  String get withTime => DateFormat.yMMMd().add_jm().format(this);
}
