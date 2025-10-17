import 'package:flutter_todo_list_riverpod/domain/todo/entities/todo.dart';
import 'package:flutter_todo_list_riverpod/domain/todo/repositories/todo_repository.dart';

class TodoUseCases {
  final Future<List<Todo>> Function() getTodos;
  final Future<Todo> Function(String title) addTodo;
  final Future<void> Function(String id) toggleComplete;
  final Future<void> Function(String id) deleteTodo;

  TodoUseCases(TodoRepository repo)
    : getTodos = repo.getTodos,
      addTodo = repo.addTodo,
      toggleComplete = repo.toggleComplete,
      deleteTodo = repo.deleteTodo;
}
