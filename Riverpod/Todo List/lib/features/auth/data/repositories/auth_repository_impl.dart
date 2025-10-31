import 'package:flutter_todo_list_riverpod/features/auth/data/datasources/auth_fake_datasource.dart';
import 'package:flutter_todo_list_riverpod/features/auth/domain/entities/logged_user.dart';
import 'package:flutter_todo_list_riverpod/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFakeDatasource authFakeDatasource;

  AuthRepositoryImpl(this.authFakeDatasource);

  @override
  Future<LoggedUser?> login(String pin) {
    return authFakeDatasource.login(pin);
  }

  @override
  void logout() {
    authFakeDatasource.logout();
  }

  @override
  Future<LoggedUser?> getLoggedUser() {
    return authFakeDatasource.getLoggedUser();
  }
}
