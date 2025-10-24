import 'package:flutter/material.dart';
import 'package:flutter_config_minima/app/theme/app_theme.dart';
import 'package:flutter_config_minima/core/widgets/auth_gate.dart';
import 'package:flutter_config_minima/features/preferences/controllers/preferences_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/todos/presentation/pages/todo_list_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(preferencesProvider);
    final themeMode = dark.when(
      data: (preferences) =>
          preferences.darkmode ? ThemeMode.dark : ThemeMode.light,
      loading: () => ThemeMode.system,
      error: (_, __) => ThemeMode.system,
    );

    return MaterialApp(
      title: 'Flutter MVC (Riverpod)',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(child: TodoListPage()),
    );
  }
}
