class Persona {
  final String name;
  final String role;
  final String? photoUrl;
  final String? nick;
  final bool isVip;

  // Constructor normal con parámetros nombrados
  const Persona({
    required this.name,
    required this.role,
    this.photoUrl,
    this.nick,
    this.isVip = false,
  });

  // Constructor en el que proporcionamos valores para todos los atributos
  const Persona.anonymous()
    : name = 'Anónimo',
      role = 'Sin rol',
      photoUrl = null,
      nick = null,
      isVip = false;

  // Factory: construir desde JSON con normalización
  factory Persona.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] as String? ?? 'Sin nombre').trim();
    final role = (json['role'] as String? ?? '—').trim();
    final photo = (json['photo'] as String?)?.trim();
    final nick = (json['nick'] as String?)?.trim();
    final vip = json['vip'] == true;
    return Persona(
      name: name.isEmpty ? 'Sin nombre' : name,
      role: role.isEmpty ? '—' : role,
      photoUrl: (photo != null && photo.isNotEmpty) ? photo : null,
      nick: (nick != null && nick.isNotEmpty) ? nick : null,
      isVip: vip,
    );
  }
}
