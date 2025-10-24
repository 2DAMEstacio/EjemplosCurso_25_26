import 'package:flutter_config_minima/features/todos/data/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  final _uuid = const Uuid();
  var _todoList = <Todo>[
    const Todo(id: '1', title: 'Comprar pan'),
    const Todo(id: '2', title: 'Enviar informe'),
    const Todo(id: '3', title: 'Llamar a Juan', completed: true),
  ];

  Future<List<Todo>> fetchAll() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return _todoList;
  }

  Future<void> toggleComplete(String id) async {
    final updatedModels = _todoList.map((todo) {
      if (todo.id == id) {
        return Todo(id: todo.id, title: todo.title, completed: !todo.completed);
      }
      return todo;
    }).toList();
    _todoList = updatedModels;
  }

  Future<Todo> addTodo(String title) async {
    final models = await fetchAll();
    final model = Todo(id: _uuid.v4(), title: title.trim(), completed: false);
    _todoList = [...models, model];
    return model;
  }

  Future<void> removeTodo(String id) async {
    _todoList.removeWhere((t) => t.id == id);
  }
}
