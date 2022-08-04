import 'package:intl/intl.dart';

String dateFormatter(DateTime date) {
  final DateFormat formatter = DateFormat('E, MMM dd, yyyy');
  final String formattedDate = formatter.format(date);
  return formattedDate;

}