import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/core/utils.dart';
import 'package:flutter_todo_list_riverpod/presentation/auth/providers/auth_providers.dart';
import 'package:flutter_todo_list_riverpod/presentation/todo/providers/todo_providers.dart';
import 'package:flutter_todo_list_riverpod/presentation/todo/widgets/todo_no_data_item.dart';
import 'package:flutter_todo_list_riverpod/presentation/todo/widgets/todo_item.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todosProvider);
    final total = ref.watch(totalTodosProvider);
    showSnackbarLogin(ref, context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis tareas ($total)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(todosProvider.notifier).refresh(),
          ),
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Cambiamos el estado de autenticación
              ref.read(isAuthenticatedProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: state.when(
        data: (todos) {
          if (todos.isEmpty) return const TodoNoDataItem();

          return ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final todo = todos[index];

              return Dismissible(
                key: ValueKey(todo.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).colorScheme.error.withAlpha(8),
                  child: const Icon(Icons.delete_outline),
                ),
                onDismissed: (_) =>
                    ref.read(todosProvider.notifier).remove(todo.id),
                child: TodoItem(todo: todo),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Añadir'),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva tarea'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Escribe el título...'),
          onSubmitted: (_) => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    final text = controller.text;
    controller.dispose();
    await ref.read(todosProvider.notifier).add(text);
  }
}
