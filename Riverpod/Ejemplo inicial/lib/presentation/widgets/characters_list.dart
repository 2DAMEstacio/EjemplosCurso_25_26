import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../data/models/character.dart';
import '../widgets/character_info_row.dart';

class CharactersList extends StatelessWidget {
  const CharactersList({super.key});

  // Función que obtiene la lista de personajes desde la API
  Future<List<Character>> _fetchCharacters() async {
    final dio = Dio();
    final response = await dio.get<Map<String, dynamic>>(
      'https://rickandmortyapi.com/api/character',
    );

    final results = response.data?['results'] as List<dynamic>? ?? [];
    return results
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: _fetchCharacters(),
      builder: (context, snapshot) {
        // 1️⃣ Estado de carga
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2️⃣ Estado de error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // 3️⃣ Estado con datos
        final characters = snapshot.data ?? [];
        if (characters.isEmpty) {
          return const Center(child: Text('No se encontraron personajes'));
        }

        // 4️⃣ Construcción del listado
        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final character = characters[index];
            return CharacterInfoRow(character: character);
          },
        );
      },
    );
  }
}
