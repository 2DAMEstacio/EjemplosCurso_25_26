import 'package:flutter_todo_list_riverpod/features/preferences/domain/entities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesLocalDataSource {
  Future<SharedPreferences> fetchPreferences() async {
    final preferenciasAlmacenadas = await SharedPreferences.getInstance();
    return preferenciasAlmacenadas;
  }

  Future<void> savePreferences(Preferences preferences) async {
    final preferenciasAlmacenadas = await SharedPreferences.getInstance();
    preferenciasAlmacenadas.setBool(
      Preferences.darkModeConst,
      preferences.darkmode,
    );
    preferenciasAlmacenadas.setString(
      Preferences.languageConst,
      preferences.language,
    );
  }
}
