import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget userAvatar(String? photoUrl, {double radius = 24}) {
  final url = _normalizeGoogleAvatar(photoUrl);
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: url == null
          ? const Icon(Icons.person)
          : CachedNetworkImage(
              imageUrl: url,
              width: radius * 2,
              height: radius * 2,
              fit: BoxFit.cover,
              // Mejora de caché / performance
              memCacheWidth: (radius * 4).toInt(), // p.ej. 96 si radius=24
              placeholder: (_, __) => const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              errorWidget: (_, __, ___) => const Icon(Icons.person),
            ),
    ),
  );
}

String? _normalizeGoogleAvatar(String? url) {
  if (url == null) return null;
  // Normaliza …=s96-c a un tamaño estable (mejor caché, menos peticiones)
  return url.replaceFirst(RegExp(r'=s\d+-c$'), '=s128-c');
}
