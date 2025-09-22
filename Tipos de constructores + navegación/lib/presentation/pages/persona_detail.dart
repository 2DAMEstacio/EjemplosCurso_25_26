import 'package:flutter/material.dart';
import 'package:flutter_tipos_constructores_navegacion/data/models/persona.dart';
import 'package:flutter_tipos_constructores_navegacion/utils/functions.dart';

class PersonaDetailPage extends StatefulWidget {
  final Persona persona;
  final VoidCallback? onToggleVip;

  const PersonaDetailPage({super.key, required this.persona, this.onToggleVip});

  @override
  State<PersonaDetailPage> createState() => _PersonaDetailPageState();
}

class _PersonaDetailPageState extends State<PersonaDetailPage> {
  late bool _isVip;

  @override
  void initState() {
    super.initState();
    _isVip = widget.persona.isVip;
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto =
        widget.persona.photoUrl != null && widget.persona.photoUrl!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.persona.name, overflow: TextOverflow.ellipsis),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage:
                  hasPhoto ? NetworkImage(widget.persona.photoUrl!) : null,
              child:
                  hasPhoto
                      ? null
                      : Text(
                        Functions.initials(widget.persona.name),
                        style: const TextStyle(fontSize: 24),
                      ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.persona.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              widget.persona.role,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (widget.persona.nick != null &&
                widget.persona.nick!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.alternate_email, size: 16),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      widget.persona.nick!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            // Aquí puedes añadir más info (bio, acciones, etc.)
            IconButton(
              iconSize: 72,
              icon: Icon(
                Icons.star,
                color: _isVip ? Colors.amber : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isVip = !_isVip;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
