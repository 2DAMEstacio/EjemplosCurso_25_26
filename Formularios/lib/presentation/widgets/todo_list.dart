import 'package:flutter/material.dart';
import 'package:flutter_forms/data/models/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({required this.todos, super.key});

  final List<Todo> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.todos[index].priority.color.withAlpha(128),
            ),
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todos[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(widget.todos[index].description),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
