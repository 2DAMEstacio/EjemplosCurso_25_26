import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool completed;

  const Todo({required this.id, required this.title, this.completed = false});

  Todo copyWith({String? id, String? title, bool? completed}) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    completed: completed ?? this.completed,
  );

  @override
  List<Object?> get props => [id, title, completed];
}
