import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_list_riverpod/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_todo_list_riverpod/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_todo_list_riverpod/features/todo/presentation/pages/todo_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthed = ref.watch(isAuthenticatedProvider);
    return isAuthed.value != null ? const TodosPage() : const LoginPage();
  }
}
