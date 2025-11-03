import 'package:flutter/material.dart';

final appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Botón dark
      foregroundColor: Colors.white,
    ),
  ),
);

final appLightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // Botón light
      foregroundColor: Colors.white,
    ),
  ),
);
