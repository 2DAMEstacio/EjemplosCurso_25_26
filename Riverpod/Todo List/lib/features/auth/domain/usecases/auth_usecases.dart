import 'package:flutter_todo_list_riverpod/features/auth/domain/entities/logged_user.dart';
import 'package:flutter_todo_list_riverpod/features/auth/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final Future<LoggedUser?> Function(String pin) login;
  final void Function() logout;
  final Future<LoggedUser?> Function() getLoggedUser;

  AuthUseCases(AuthRepository repo)
    : login = repo.login,
      logout = repo.logout,
      getLoggedUser = repo.getLoggedUser;
}
