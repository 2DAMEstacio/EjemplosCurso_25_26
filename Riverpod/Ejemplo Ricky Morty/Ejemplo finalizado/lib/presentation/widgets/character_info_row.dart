import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/data/models/character.dart';
import 'package:flutter_riverpod_ejemplo/presentation/providers/fav_characters_provider.dart';

class CharacterInfoRow extends ConsumerWidget {
  final Character characterInfo;

  const CharacterInfoRow({super.key, required this.characterInfo});

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Set<Character> favCharacters = ref.watch(favCharacterProvider);
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(characterInfo.imageUrl),
        ),
        title: Text(
          characterInfo.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status con puntito de color
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: _statusColor(characterInfo.status),
                ),
                const SizedBox(width: 6),
                Text(
                  characterInfo.status,
                  style: TextStyle(
                    fontSize: 14,
                    color: _statusColor(characterInfo.status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Especie y género
            Text(
              '${characterInfo.species} · ${characterInfo.gender}',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
          ],
        ),

        trailing: favCharacters.contains(characterInfo)
            ? IconButton(
                onPressed: () {
                  ref
                      .read(favCharacterProvider.notifier)
                      .removeCharacter(characterInfo);
                },
                icon: Icon(Icons.star, color: Colors.amber),
              )
            : IconButton(
                onPressed: () {
                  ref
                      .read(favCharacterProvider.notifier)
                      .addCharacter(characterInfo);
                },
                icon: Icon(Icons.star, color: Colors.grey),
              ),
      ),
    );
  }
}
