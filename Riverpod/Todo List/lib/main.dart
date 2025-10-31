import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/features/auth/presentation/widgets/auth_gate.dart';
import 'package:flutter_todo_list_riverpod/features/preferences/presentation/providers/preferences_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: TodoApp()));
}

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefsAsync = ref.watch(preferencesProvider);

    final modoOscuro = prefsAsync.maybeWhen(
      data: (p) => p.darkmode,
      orElse: () => false,
    );

    final dark = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Todo List utilizando Riverpod',
      debugShowCheckedModeBanner: false,
      darkTheme: dark,
      themeMode: modoOscuro ? ThemeMode.dark : ThemeMode.light,
      home: const AuthGate(),
    );
  }
}
