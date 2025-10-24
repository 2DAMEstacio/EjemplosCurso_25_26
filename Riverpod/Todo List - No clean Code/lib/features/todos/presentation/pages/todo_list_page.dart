import 'package:flutter/material.dart';
import 'package:flutter_config_minima/core/utils/utils.dart';
import 'package:flutter_config_minima/core/widgets/auth_gate.dart';
import 'package:flutter_config_minima/core/widgets/app_drawer.dart';
import 'package:flutter_config_minima/features/preferences/presentation/pages/preferences_page.dart';
import 'package:flutter_config_minima/features/todos/controllers/todo_controller.dart';
import 'package:flutter_config_minima/features/todos/presentation/widgets/add_todo_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    showSnackbarLogin(ref, context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
            tooltip: 'Preferencias',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AuthGate(child: PreferencesPage()),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: todos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) => ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final t = items[i];
            return Dismissible(
              key: ValueKey(t.id),
              background: Container(color: Colors.red),
              onDismissed: (_) => ref.read(todosProvider.notifier).remove(t.id),
              child: CheckboxListTile(
                value: t.completed,
                title: Text(t.title),
                onChanged: (_) => ref.read(todosProvider.notifier).toggle(t.id),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (_) => const AddTodoDialog(),
          );
          if (title != null && title.trim().isNotEmpty) {
            await ref.read(todosProvider.notifier).add(title.trim());
          }
        },
        label: const Text('Nuevo'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
