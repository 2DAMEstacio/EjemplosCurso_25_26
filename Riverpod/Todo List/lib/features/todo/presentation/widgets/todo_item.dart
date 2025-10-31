import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/features/todo/domain/entities/todo.dart';
import 'package:flutter_todo_list_riverpod/features/todo/presentation/providers/todo_providers.dart';

class TodoItem extends ConsumerWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) => ref.read(todosProvider.notifier).toggle(todo.id),
      ),
      title: Text(
        todo.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: todo.completed
            ? const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              )
            : null,
      ),
      subtitle: Text(
        'Creado: ${_formatDate(todo.createdAt)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => ref.read(todosProvider.notifier).remove(todo.id),
      ),
    );
  }

  String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/'
      '${dt.month.toString().padLeft(2, '0')}/'
      '${dt.year} '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}
