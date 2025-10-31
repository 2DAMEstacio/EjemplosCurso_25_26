import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/features/auth/presentation/providers/auth_providers.dart';

void showSnackbarLogin(WidgetRef ref, BuildContext context) {
  ref.listen<bool>(isAuthenticatedProvider, (prev, next) {
    if (prev == true && next == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('👋 Sesión cerrada'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (prev == false && next == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Acceso concedido'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  });
}
