import 'package:flutter/material.dart';
import 'package:flutter_theme_botones/app/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo del tema light/dark',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tema Light / Dark'),
          actions: [
            Switch(
              value: _themeMode == ThemeMode.dark,
              onChanged: (value) {
                setState(() {
                  _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Mi Botón'),
          ),
        ),
      ),
    );
  }
}
