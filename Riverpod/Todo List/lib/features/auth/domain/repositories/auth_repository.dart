import 'package:flutter_todo_list_riverpod/features/auth/domain/entities/logged_user.dart';

abstract class AuthRepository {
  Future<LoggedUser?> login(String pin);
  void logout();
  Future<LoggedUser?> getLoggedUser();
}
