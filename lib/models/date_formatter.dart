import 'package:intl/intl.dart';

// Used to format date in Mon, Jan 01, 0101
String dateFormatter(DateTime date) {
  final DateFormat formatter = DateFormat('E, MMM dd, yyyy');
  final String formattedDate = formatter.format(date);
  return formattedDate;

}