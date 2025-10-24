import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_config_minima/features/auth/data/models/user.dart';
import 'package:flutter_config_minima/features/auth/data/repositories/auth_repository.dart';

class AuthController extends AsyncNotifier<User?> {
  late final AuthRepository _repo;

  @override
  Future<User?> build() async {
    _repo = AuthRepository();
    return _loadUserFromStorage();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadUserFromStorage);
  }

  Future<void> login(String email, String password) async {
    try {
      state = const AsyncLoading();

      if (email.isEmpty || password.length < 4) {
        throw Exception('Credenciales inválidas');
      }

      final token = 'token_${DateTime.now().millisecondsSinceEpoch}';
      await _repo.saveAuth(email: email, token: token);

      final logged = User(id: '1', email: email, token: token);
      state = AsyncValue.data(logged);

      state = await AsyncValue.guard(_loadUserFromStorage);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> logout() async {
    try {
      await _repo.clearAuth();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<User?> _loadUserFromStorage() async {
    final token = await _repo.getToken();
    final email = await _repo.getEmail();
    if (token != null && email != null) {
      return User(id: 'restored', email: email, token: token);
    }
    return null;
  }
}

// Provider al estilo que prefieres (sin .new)
final authProvider = AsyncNotifierProvider<AuthController, User?>(() {
  return AuthController();
});
