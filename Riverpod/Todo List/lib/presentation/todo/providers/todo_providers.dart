// Infra
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/data/todo/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_list_riverpod/data/todo/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_list_riverpod/domain/todo/entities/todo.dart';
import 'package:flutter_todo_list_riverpod/domain/todo/usecases/todo_usecases.dart';

class TodosNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoUseCases todoUseCases;

  @override
  Future<List<Todo>> build() async {
    todoUseCases = TodoUseCases(TodoRepositoryImpl(TodoLocalDataSource()));
    return todoUseCases.getTodos();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(todoUseCases.getTodos);
  }

  Future<void> add(String title) async {
    if (title.trim().isEmpty) return;
    final previous = state.value ?? const <Todo>[];
    try {
      final created = await todoUseCases.addTodo(title);
      state = AsyncValue.data([...previous, created]);
      state = await AsyncValue.guard(todoUseCases.getTodos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggle(String id) async {
    try {
      await todoUseCases.toggleComplete(id);
      state = await AsyncValue.guard(todoUseCases.getTodos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String id) async {
    try {
      await todoUseCases.deleteTodo(id);
      state = await AsyncValue.guard(todoUseCases.getTodos);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final todosProvider = AsyncNotifierProvider<TodosNotifier, List<Todo>>(() {
  return TodosNotifier();
});

final totalTodosProvider = Provider<int>((ref) {
  final todos = ref.watch(todosProvider).value ?? const <Todo>[];
  return todos.length;
});
