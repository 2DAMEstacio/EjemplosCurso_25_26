// Infra
import 'package:flutter_config_minima/features/todos/data/models/todo.dart';
import 'package:flutter_config_minima/features/todos/data/repositories/todo_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosNotifier extends AsyncNotifier<List<Todo>> {
  late final TodoRepository _repo;

  @override
  Future<List<Todo>> build() async {
    _repo = TodoRepository();
    return _repo.fetchAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repo.fetchAll);
  }

  Future<void> add(String title) async {
    if (title.trim().isEmpty) return;
    final previous = state.value ?? const <Todo>[];
    try {
      final created = await _repo.addTodo(title);
      state = AsyncValue.data([...previous, created]);
      state = await AsyncValue.guard(_repo.fetchAll);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggle(String id) async {
    try {
      await _repo.toggleComplete(id);
      state = await AsyncValue.guard(_repo.fetchAll);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String id) async {
    try {
      await _repo.removeTodo(id);
      state = await AsyncValue.guard(_repo.fetchAll);
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
