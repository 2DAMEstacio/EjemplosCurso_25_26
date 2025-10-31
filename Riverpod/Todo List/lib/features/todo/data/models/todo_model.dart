import 'package:flutter_todo_list_riverpod/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  final String? level;

  const TodoModel({
    required super.id,
    required super.title,
    required super.completed,
    this.level,
    required super.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'] as String,
    title: json['title'] as String,
    completed: json['completed'] as bool,
    level: json['level'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'completed': completed,
    'level': level,
    'createdAt': createdAt.toIso8601String(),
  };
}
