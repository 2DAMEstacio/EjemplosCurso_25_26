import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tipos_constructores_navegacion/data/fake_data/personas_list.dart';
import 'package:flutter_tipos_constructores_navegacion/presentation/widgets/persona_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Personas')),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: listadoPersonas.length,
          itemBuilder: (context, index) {
            final p = listadoPersonas[index];
            final r = Random();
            final valor = r.nextInt(4) + 1;

            switch (valor) {
              case 1:
                return PersonaCard(
                  name: (p['name'] as String?) ?? 'Sin nombre',
                  role: (p['role'] as String?) ?? '—',
                  photoUrl: p['photo'] as String?,
                );
              case 2:
                return PersonaCard.compact(
                  name: (p['name'] as String?) ?? 'Sin nombre',
                  role: (p['role'] as String?) ?? '—',
                );
              case 3:
                return PersonaCard.vip(
                  name: (p['name'] as String?) ?? 'Sin nombre',
                  role: (p['role'] as String?) ?? '—',
                  photoUrl: p['photo'] as String?,
                );
              default:
                return PersonaCard.fromJson(p);
            }
          },
        ),
      ),
    );
  }
}
