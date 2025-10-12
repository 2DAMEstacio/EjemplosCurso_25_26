import 'package:flutter/material.dart';
import '../../data/models/character.dart';

class CharacterInfoRow extends StatelessWidget {
  final Character character;

  const CharacterInfoRow({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.imageUrl),
          radius: 28,
        ),
        title: Text(
          character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${character.species} • ${character.status}',
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
