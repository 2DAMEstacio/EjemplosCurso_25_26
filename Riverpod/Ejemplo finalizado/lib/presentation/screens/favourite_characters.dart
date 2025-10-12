import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/data/models/character.dart';
import 'package:flutter_riverpod_ejemplo/presentation/providers/fav_characters_provider.dart';

class FavouriteCharacters extends ConsumerWidget {
  const FavouriteCharacters({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<Character> favCharacters = ref.watch(favCharacterProvider);
    final int smithFamily = ref.watch(totalSmithFamiliyCharacterProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Persons favoritos")),
      body: ListView.builder(
        itemCount: favCharacters.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(title: Text(favCharacters.toList()[index].name)),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'De la familia Smith $smithFamily',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
