import 'package:flutter/material.dart';

enum TodoPriority {
  urgent('Urgente'),
  high('Alta'),
  medium('Media'),
  low('Baja');

  final String label;
  const TodoPriority(this.label);

  Color get color {
    switch (this) {
      case TodoPriority.urgent:
        return Colors.red;
      case TodoPriority.high:
        return Colors.orange;
      case TodoPriority.medium:
        return Colors.amber;
      case TodoPriority.low:
        return Colors.green;
    }
  }
}

class Todo {
  final String title;
  final String description;
  final TodoPriority priority;

  const Todo({
    required this.title,
    required this.description,
    required this.priority,
  });
}
