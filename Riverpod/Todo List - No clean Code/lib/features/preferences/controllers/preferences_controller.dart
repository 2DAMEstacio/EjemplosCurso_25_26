// Infra
import 'package:flutter_config_minima/features/preferences/data/models/preferences.dart';
import 'package:flutter_config_minima/features/preferences/data/repositories/preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferencesNotifier extends AsyncNotifier<Preferences> {
  late final PreferencesRepository _repo;

  @override
  Future<Preferences> build() async {
    _repo = PreferencesRepository();
    return _repo.getPreferences();
  }

  Future<void> updatePreferences(Preferences newPreferences) async {
    try {
      state = const AsyncLoading();
      await _repo.setPreferences(newPreferences);
      state = AsyncValue.data(newPreferences);
      state = await AsyncValue.guard(_repo.getPreferences);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final preferencesProvider =
    AsyncNotifierProvider<PreferencesNotifier, Preferences>(() {
      return PreferencesNotifier();
    });
