import 'package:intl/intl.dart';

String formatSampleDate(DateTime date) => DateFormat.yMMMd().format(date);
String formatSampleCurrency(num amount) =>
    NumberFormat.simpleCurrency(name: 'EUR').format(amount);
