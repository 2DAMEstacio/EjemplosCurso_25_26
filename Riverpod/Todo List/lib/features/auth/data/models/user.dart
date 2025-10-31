import 'package:flutter_todo_list_riverpod/features/auth/domain/entities/logged_user.dart';

class User extends LoggedUser {
  final int age;

  const User({required super.name, super.email, required this.age});
}
