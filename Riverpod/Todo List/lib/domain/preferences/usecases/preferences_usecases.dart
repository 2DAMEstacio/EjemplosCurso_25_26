import 'package:flutter_todo_list_riverpod/domain/preferences/entities/preferences.dart';
import 'package:flutter_todo_list_riverpod/domain/preferences/repositories/preferences_repository.dart';

class PreferencesUseCases {
  final Future<Preferences> Function() getPreferences;
  final Future<void> Function(Preferences preferences) setPreferences;

  PreferencesUseCases(PreferencesRepository repo)
    : getPreferences = repo.getPreferences,
      setPreferences = repo.setPreferences;
}
