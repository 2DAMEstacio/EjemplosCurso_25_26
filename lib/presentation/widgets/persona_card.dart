import 'package:flutter/material.dart';
import 'package:flutter_tipos_constructores_navegacion/data/models/persona.dart';
import 'package:flutter_tipos_constructores_navegacion/presentation/pages/persona_detail.dart';
import 'package:flutter_tipos_constructores_navegacion/utils/functions.dart';

class PersonaCard extends StatelessWidget {
  final String name;
  final String role;
  final String? photoUrl;
  final String? nick;
  final bool isVip;

  //Named constructor con valores por defecto
  const PersonaCard({
    super.key,
    required this.name,
    required this.role,
    this.photoUrl,
    this.nick,
    this.isVip = false,
  });

  //Named constructor con valores inicializados
  const PersonaCard.vip({
    super.key,
    required this.name,
    required this.role,
    this.photoUrl,
    this.nick,
  }) : isVip = true;

  //Named constructor con valores inicializados
  const PersonaCard.compact({
    super.key,
    required this.name,
    required this.role,
    this.photoUrl,
    this.nick,
  }) : isVip = false;

  //Constructor factory
  factory PersonaCard.fromJson(Map<String, dynamic> json) {
    final persona = Persona.fromJson(json);
    return PersonaCard(
      name: persona.name,
      role: persona.role,
      photoUrl: persona.photoUrl,
      nick: persona.nick,
      isVip: persona.isVip,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: hasPhoto ? NetworkImage(photoUrl!) : null,
          child: hasPhoto ? null : Text(Functions.initials(name)),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            if (isVip) const Icon(Icons.star, size: 18, color: Colors.amber),
          ],
        ),
        subtitle: Text(role, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Persona persona = Persona(
            name: name,
            role: role,
            photoUrl: photoUrl,
            nick: nick,
            isVip: isVip,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonaDetailPage(persona: persona),
            ),
          );
        },
      ),
    );
  }
}
