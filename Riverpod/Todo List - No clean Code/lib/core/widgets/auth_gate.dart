import 'package:flutter/material.dart';
import 'package:flutter_config_minima/features/auth/controllers/auth_controller.dart';
import 'package:flutter_config_minima/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);
    return authAsync.when(
      data: (user) {
        if (user == null) return const LoginPage();
        return child;
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) {
        debugPrint('Error:$err');
        return const LoginPage();
      },
    );
  }
}
