import 'package:flutter/material.dart';
import 'package:flutter_login/core/pages/error_page.dart';
import 'package:flutter_login/core/pages/splash_page.dart';
import 'package:flutter_login/features/auth/controllers/auth_controller.dart';
import 'package:flutter_login/features/auth/data/models/user.dart';
import 'package:flutter_login/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  final Widget Function(User user) builder;
  final Widget? loading;

  const AuthGate({super.key, required this.builder, this.loading});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return authState.when(
      loading: () => loading ?? const SplashPage(),
      error: (e, _) => ErrorPage(error: e.toString()),
      data: (user) {
        if (user == null) return const LoginPage();
        return builder(user);
      },
    );
  }
}
