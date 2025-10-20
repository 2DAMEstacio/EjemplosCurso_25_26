import 'package:flutter_todo_list_riverpod/domain/preferences/entities/preferences.dart';

abstract class PreferencesRepository {
  Future<Preferences> getPreferences();
  Future<void> setPreferences(Preferences preferences);
}
