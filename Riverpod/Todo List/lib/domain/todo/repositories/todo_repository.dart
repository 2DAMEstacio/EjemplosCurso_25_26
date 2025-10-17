import 'package:flutter_todo_list_riverpod/domain/todo/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> addTodo(String title);
  Future<void> toggleComplete(String id);
  Future<void> deleteTodo(String id);
}
