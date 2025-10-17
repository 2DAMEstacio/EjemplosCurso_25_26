import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pin secreto para acceso (en un caso real vendría de un backend o secure storage)
const String kSecretPin = '4242';

class AuthNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void logout() {
    state = false;
  }

  bool loginWithPin(String pin) {
    final ok = pin.trim() == kSecretPin;
    if (ok) state = true;
    return ok;
  }
}

final isAuthenticatedProvider = NotifierProvider<AuthNotifier, bool>(() {
  return AuthNotifier();
});
