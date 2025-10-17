import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/presentation/providers/characters_provider.dart';
import 'package:flutter_riverpod_ejemplo/presentation/widgets/character_info_row.dart';

class CharacterList extends ConsumerWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChars = ref.watch(charactersProvider);

    return asyncChars.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (list) => ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return CharacterInfoRow(characterInfo: list[index]);
        },
      ),
    );
  }
}
