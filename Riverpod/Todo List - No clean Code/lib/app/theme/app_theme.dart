import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
