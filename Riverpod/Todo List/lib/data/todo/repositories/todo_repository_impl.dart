import 'package:flutter_todo_list_riverpod/data/todo/datasources/todo_local_datasource.dart';
import 'package:flutter_todo_list_riverpod/data/todo/models/todo_model.dart';
import 'package:flutter_todo_list_riverpod/domain/todo/entities/todo.dart';
import 'package:flutter_todo_list_riverpod/domain/todo/repositories/todo_repository.dart';
import 'package:uuid/uuid.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDatasource;
  final _uuid = const Uuid();

  TodoRepositoryImpl(this.localDatasource);

  @override
  Future<List<Todo>> getTodos() async {
    final models = await localDatasource.fetchAll();
    return models;
  }

  @override
  Future<Todo> addTodo(String title) async {
    final models = await localDatasource.fetchAll();
    final model = TodoModel(
      id: _uuid.v4(),
      title: title.trim(),
      completed: false,
      createdAt: DateTime.now(),
    );
    final updated = [...models, model];
    await localDatasource.saveAll(updated);
    return model;
  }

  @override
  Future<void> toggleComplete(String id) async {
    final models = await localDatasource.fetchAll();

    // Buscamos la tarea a modificar
    final updatedModels = models.map((todo) {
      if (todo.id == id) {
        return TodoModel(
          id: todo.id,
          title: todo.title,
          completed: !todo.completed,
          createdAt: todo.createdAt,
        );
      }
      return todo;
    }).toList();

    await localDatasource.saveAll(updatedModels);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final models = await localDatasource.fetchAll();
    final updated = models.where((m) => m.id != id).toList();
    await localDatasource.saveAll(updated);
  }
}
