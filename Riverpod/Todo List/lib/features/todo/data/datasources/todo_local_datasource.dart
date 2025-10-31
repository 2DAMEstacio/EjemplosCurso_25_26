import 'package:flutter_todo_list_riverpod/features/todo/data/models/todo_model.dart';

class TodoLocalDataSource {
  List<TodoModel> _todoList = [];

  Future<List<TodoModel>> fetchAll() async {
    return _todoList;
  }

  Future<void> saveAll(List<TodoModel> todos) async {
    _todoList = todos;
  }
}
