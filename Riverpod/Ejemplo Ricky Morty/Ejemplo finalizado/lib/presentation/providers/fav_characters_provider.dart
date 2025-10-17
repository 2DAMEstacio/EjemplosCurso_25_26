import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/data/models/character.dart';

class FavCharacterNotifier extends Notifier<Set<Character>> {
  @override
  Set<Character> build() {
    return const {};
  }

  void addCharacter(Character character) {
    if (!state.contains(character)) {
      state = {...state, character};
    }
  }

  void removeCharacter(Character character) {
    if (state.contains(character)) {
      state = state.where((p) => p.id != character.id).toSet();
    }
  }
}

final favCharacterProvider =
    NotifierProvider<FavCharacterNotifier, Set<Character>>(() {
      return FavCharacterNotifier();
    });

final totalSmithFamiliyCharacterProvider = Provider<int>((ref) {
  final totalFav = ref
      .watch(favCharacterProvider)
      .toList()
      .where((character) => character.name.contains("Smith"))
      .length;
  return totalFav;
});
