import 'package:equatable/equatable.dart';

class Preferences extends Equatable {
  static const darkModeConst = 'DARKMODE';
  static const languageConst = 'LANGUAGE';

  final bool darkmode;
  final String language;

  const Preferences({required this.darkmode, required this.language});

  Preferences copyWith({bool? darkmode, String? language}) => Preferences(
    darkmode: darkmode ?? this.darkmode,
    language: language ?? this.language,
  );

  @override
  List<Object?> get props => [darkmode, language];
}
