import 'package:flutter_todo_list_riverpod/features/preferences/data/datasources/preferences_local_datasource.dart';
import 'package:flutter_todo_list_riverpod/features/preferences/domain/entities/preferences.dart';
import 'package:flutter_todo_list_riverpod/features/preferences/domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesLocalDataSource localDatasource;

  PreferencesRepositoryImpl(this.localDatasource);

  @override
  Future<Preferences> getPreferences() async {
    final preferenciasAlmacenadas = await localDatasource.fetchPreferences();
    bool darkmodeAlm =
        preferenciasAlmacenadas.getBool(Preferences.darkModeConst) ?? false;
    String languageAlm =
        preferenciasAlmacenadas.getString(Preferences.languageConst) ?? 'es';
    return Preferences(darkmode: darkmodeAlm, language: languageAlm);
  }

  @override
  Future<void> setPreferences(Preferences preferences) async {
    await localDatasource.savePreferences(preferences);
  }
}
