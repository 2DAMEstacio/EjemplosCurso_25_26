import 'package:flutter/material.dart';
import 'package:flutter_config_minima/core/widgets/auth_gate.dart';
import 'package:flutter_config_minima/features/auth/controllers/auth_controller.dart';
import 'package:flutter_config_minima/features/preferences/presentation/pages/preferences_page.dart';
import 'package:flutter_config_minima/features/todos/presentation/pages/todo_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AuthGate(child: page)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Dos versiones distintas para leer la información del usuario

    //VERSIÓN 1
    // final auth = ref.watch(authProvider);
    // String loggedUserEmail = auth.whenOrNull(data: (user) => user?.email) ?? "";

    //VERSIÓN 2
    final prefs = ref.read(authProvider).value;
    String loggedUserEmail = "";
    if (prefs != null) {
      loggedUserEmail = prefs.email;
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Hola $loggedUserEmail!!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Todos'),
            onTap: () {
              Navigator.pop(context);
              _open(context, const TodoListPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Preferencias'),
            onTap: () {
              Navigator.pop(context);
              _open(context, const PreferencesPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
    );
  }
}
