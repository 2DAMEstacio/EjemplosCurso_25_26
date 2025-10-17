import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/presentation/auth/pages/login_page.dart';
import 'package:flutter_todo_list_riverpod/presentation/auth/providers/auth_providers.dart';
import 'package:flutter_todo_list_riverpod/presentation/todo/pages/todo_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthed = ref.watch(isAuthenticatedProvider);
    return isAuthed ? const TodosPage() : const LoginPage();
  }
}
