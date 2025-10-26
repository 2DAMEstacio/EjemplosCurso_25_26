// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Compañero de estudio i18n';

  @override
  String hello(String name) {
    return '¡Hola, $name!';
  }

  @override
  String applesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count manzanas',
      one: 'Una manzana',
      zero: 'Sin manzanas',
    );
    return '$_temp0';
  }

  @override
  String userGender(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'Él',
      'female': 'Ella',
      'other': 'Elle',
    });
    return '$_temp0 eligió Español.';
  }

  @override
  String dueDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Vence el $dateString';
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
  String get openLanguagePicker => 'Cambiar idioma';

  @override
  String get concepts => 'Conceptos';

  @override
  String get concept_plural => 'Plural';

  @override
  String get concept_select => 'Selecciona (género)';

  @override
  String get concept_placeholders => 'Placeholders (fecha/número)';
}
