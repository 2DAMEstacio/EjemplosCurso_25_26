import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/data/models/character.dart';

final dio = Dio();
final charactersProvider = FutureProvider<List<Character>>((ref) async {
  final response = await dio.get<Map<String, Object?>>(
    'https://rickandmortyapi.com/api/character',
  );
  final data = response.data;
  if (data == null) {
    throw Exception('Respuesta vacía de la API');
  }
  final results = data['results'] as List<dynamic>?;
  if (results == null) {
    throw Exception('Formato inesperado: falta "results"');
  }

  return results
      .map((e) => Character.fromJson(e as Map<String, dynamic>))
      .toList();
});
