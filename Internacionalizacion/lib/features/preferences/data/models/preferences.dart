import 'dart:ui';

class Preferences {
  final bool darkmode;
  final Locale language;

  const Preferences({required this.darkmode, required this.language});

  Preferences copyWith({bool? darkmode, Locale? language}) => Preferences(
    darkmode: darkmode ?? this.darkmode,
    language: language ?? this.language,
  );
}
