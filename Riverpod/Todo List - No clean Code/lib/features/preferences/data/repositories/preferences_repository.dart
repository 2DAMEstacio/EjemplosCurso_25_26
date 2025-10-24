import 'package:flutter_config_minima/features/preferences/data/models/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  static const _keyDarkMode = 'DARKMODE';
  static const _keyLanguage = 'LANGUAGE';

  Future<Preferences> getPreferences() async {
    final preferenciasAlmacenadas = await SharedPreferences.getInstance();
    bool darkmodeAlm = preferenciasAlmacenadas.getBool(_keyDarkMode) ?? false;
    String languageAlm =
        preferenciasAlmacenadas.getString(_keyLanguage) ?? 'es';

    return Preferences(darkmode: darkmodeAlm, language: languageAlm);
  }

  Future<void> setPreferences(Preferences preferences) async {
    final preferenciasAlmacenadas = await SharedPreferences.getInstance();
    preferenciasAlmacenadas.setBool(_keyDarkMode, preferences.darkmode);
    preferenciasAlmacenadas.setString(_keyLanguage, preferences.language);
  }
}
