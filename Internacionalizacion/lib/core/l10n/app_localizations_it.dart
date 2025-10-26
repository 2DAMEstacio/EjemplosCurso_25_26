// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Compagno di studio i18n';

  @override
  String hello(String name) {
    return 'Ciao, $name!';
  }

  @override
  String applesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mele',
      one: 'Una mela',
      zero: 'Nessuna mela',
    );
    return '$_temp0';
  }

  @override
  String userGender(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'Lui',
      'female': 'Lei',
      'other': 'Loro',
    });
    return '$_temp0 ha scelto l\'Italiano.';
  }

  @override
  String dueDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Scadenza il $dateString';
  }

  @override
  String price(num amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      name: 'EUR',
    );
    final String amountString = amountNumberFormat.format(amount);

    return 'Totale: $amountString';
  }

  @override
  String get openLanguagePicker => 'Cambia lingua';

  @override
  String get concepts => 'Concetti';

  @override
  String get concept_plural => 'Plurale';

  @override
  String get concept_select => 'Select (genere)';

  @override
  String get concept_placeholders => 'Segnaposto (data/numero)';
}
