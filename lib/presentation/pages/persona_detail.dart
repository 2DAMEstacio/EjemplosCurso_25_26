import 'package:flutter/material.dart';
import 'package:flutter_tipos_constructores_navegacion/data/models/persona.dart';
import 'package:flutter_tipos_constructores_navegacion/utils/functions.dart';

class PersonaDetailPage extends StatelessWidget {
  final Persona persona;

  const PersonaDetailPage({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = persona.photoUrl != null && persona.photoUrl!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(persona.name, overflow: TextOverflow.ellipsis),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage:
                  hasPhoto ? NetworkImage(persona.photoUrl!) : null,
              child:
                  hasPhoto
                      ? null
                      : Text(
                        Functions.initials(persona.name),
                        style: const TextStyle(fontSize: 24),
                      ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    persona.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (persona.isVip) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.star, color: Colors.amber),
                ],
              ],
            ),
            const SizedBox(height: 6),
            Text(
              persona.role,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (persona.nick != null && persona.nick!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.alternate_email, size: 16),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(persona.nick!, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            // Aquí puedes añadir más info (bio, acciones, etc.)
          ],
        ),
      ),
    );
  }
}
