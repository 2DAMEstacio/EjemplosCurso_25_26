// Infra
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/data/preferences/datasources/preferences_local_datasource.dart';
import 'package:flutter_todo_list_riverpod/data/preferences/repositories/preferences_repository_impl.dart';
import 'package:flutter_todo_list_riverpod/domain/preferences/entities/preferences.dart';
import 'package:flutter_todo_list_riverpod/domain/preferences/usecases/preferences_usecases.dart';

class PreferencesNotifier extends AsyncNotifier<Preferences> {
  late final PreferencesUseCases preferencesUseCases;

  @override
  Future<Preferences> build() async {
    preferencesUseCases = PreferencesUseCases(
      PreferencesRepositoryImpl(PreferencesLocalDataSource()),
    );
    return preferencesUseCases.getPreferences();
  }

  Future<void> updatePreferences(Preferences newPreferences) async {
    try {
      state = const AsyncLoading();
      await preferencesUseCases.setPreferences(newPreferences);
      state = AsyncValue.data(newPreferences);
      state = await AsyncValue.guard(preferencesUseCases.getPreferences);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final preferencesProvider =
    AsyncNotifierProvider<PreferencesNotifier, Preferences>(() {
      return PreferencesNotifier();
    });
