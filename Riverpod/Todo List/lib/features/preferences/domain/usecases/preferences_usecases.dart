import 'package:flutter_todo_list_riverpod/features/preferences/domain/entities/preferences.dart';
import 'package:flutter_todo_list_riverpod/features/preferences/domain/repositories/preferences_repository.dart';

class PreferencesUseCases {
  final Future<Preferences> Function() getPreferences;
  final Future<void> Function(Preferences preferences) setPreferences;

  PreferencesUseCases(PreferencesRepository repo)
    : getPreferences = repo.getPreferences,
      setPreferences = repo.setPreferences;
}
