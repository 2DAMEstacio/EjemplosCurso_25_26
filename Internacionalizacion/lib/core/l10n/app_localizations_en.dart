// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'i18n Study Buddy';

  @override
  String hello(String name) {
    return 'Hello, $name!';
  }

  @override
  String applesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count apples',
      one: 'One apple',
      zero: 'No apples',
    );
    return '$_temp0';
  }

  @override
  String userGender(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'He',
      'female': 'She',
      'other': 'They',
    });
    return '$_temp0 chose English.';
  }

  @override
  String dueDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Due on $dateString';
  }

  @override
  String price(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      name: 'EUR',
    );
    final String amountString = amountNumberFormat.format(amount);

    return 'Total: $amountString';
  }

  @override
  String get openLanguagePicker => 'Change language';

  @override
  String get concepts => 'Concepts';

  @override
  String get concept_plural => 'Plural';

  @override
  String get concept_select => 'Select (gender)';

  @override
  String get concept_placeholders => 'Placeholders (date/number)';
}
