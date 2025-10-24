class Preferences {
  final bool darkmode;
  final String language;

  const Preferences({required this.darkmode, required this.language});

  Preferences copyWith({bool? darkmode, String? language}) => Preferences(
    darkmode: darkmode ?? this.darkmode,
    language: language ?? this.language,
  );
}
