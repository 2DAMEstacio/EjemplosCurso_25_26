import 'package:flutter/material.dart';
import 'package:flutter_config_minima/features/auth/controllers/auth_controller.dart';
import 'package:flutter_config_minima/features/auth/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showSnackbarLogin(WidgetRef ref, BuildContext context) {
  ref.listen<AsyncValue<User?>>(authProvider, (prev, next) {
    final wasLoggedIn = prev?.hasValue == true && prev!.value != null;
    final isLoggedIn = next.hasValue && next.value != null;

    if (wasLoggedIn && !isLoggedIn) {
      // Logout
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('👋 Sesión cerrada'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (!wasLoggedIn && isLoggedIn) {
      // Login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Acceso concedido'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  });
}
