import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_google/features/auth/data/models/app_user.dart';
import 'package:flutter_login_google/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// StreamProvider para escuchar login/logout de FirebaseAuth
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuthRepository().authChanges();
});

class AuthController extends AsyncNotifier<AppUser?> {
  final FirebaseAuthRepository _repo = FirebaseAuthRepository();

  @override
  Future<AppUser?> build() async {
    ref.listen<AsyncValue<User?>>(authStateProvider, (_, next) async {
      final user = next.asData?.value;
      final appUser = await _fetchUser(user);
      state = AsyncData(appUser);
    });

    final initialUser = _repo.currentUser();
    return _fetchUser(initialUser);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      UserCredential userCredentials = await _repo.signInWithGoogle();
      final currentUser = userCredentials.user;
      state = AsyncData(await _fetchUser(currentUser));
    } on FirebaseAuthException catch (e) {
      state = AsyncError(e.message ?? e.code, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AsyncData(null);
  }

  Future<AppUser?> _fetchUser(User? currentUser) async {
    if (currentUser == null) return null;
    final token = await _repo.idToken();
    final role = await _repo.fetchUserRole(currentUser.uid);
    return AppUser.fromFirebase(currentUser, role: role, idToken: token);
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    state = const AsyncLoading();
    try {
      UserCredential userCredentials = await _repo.signInWithEmailPassword(
        email: email,
        password: password,
      );
      final currentUser = userCredentials.user;
      state = AsyncData(await _fetchUser(currentUser));
    } on FirebaseAuthException catch (e) {
      state = AsyncError(e.message ?? e.code, StackTrace.current);
    }
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    state = const AsyncLoading();
    try {
      UserCredential userCredentials = await _repo.registerWithEmailPassword(
        email: email,
        password: password,
      );
      final currentUser = userCredentials.user;
      state = AsyncData(await _fetchUser(currentUser));
    } on FirebaseAuthException catch (e) {
      state = AsyncError(e.message ?? e.code, StackTrace.current);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _repo.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      state = AsyncError(e.message ?? e.code, StackTrace.current);
    }
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  () {
    return AuthController();
  },
);
