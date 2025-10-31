import 'package:flutter_todo_list_riverpod/features/preferences/domain/entities/preferences.dart';

abstract class PreferencesRepository {
  Future<Preferences> getPreferences();
  Future<void> setPreferences(Preferences preferences);
}
