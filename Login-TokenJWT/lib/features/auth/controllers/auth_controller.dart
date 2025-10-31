import 'package:flutter_login/features/auth/data/models/user.dart';
import 'package:flutter_login/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends AsyncNotifier<User?> {
  final AuthRepository _repo = AuthRepository();

  @override
  Future<User?> build() async {
    try {
      final token = await _repo.readToken();
      if (token == null) return null;
      final user = await _repo.getLoggedUserData();
      return user;
    } catch (_) {
      await _repo.logout();
      return null;
    }
  }

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    state = const AsyncLoading();
    try {
      await _repo.login(username: username, password: password);
      final user = await _repo.getLoggedUserData();
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
      state = const AsyncData(null);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _repo.logout();
    state = const AsyncData(null);
  }

  Future<User> reloadProfile() async {
    final user = await _repo.getLoggedUserData();
    state = AsyncData(user);
    return user;
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(() {
  return AuthController();
});
