import 'package:flutter/material.dart';
import 'package:flutter_login_google/features/auth/controller/auth_controller.dart';
import 'package:flutter_login_google/features/auth/data/models/app_user.dart';
import 'package:flutter_login_google/features/auth/presentation/widgets/user_avatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHome extends ConsumerWidget {
  final AppUser user;
  const UserHome({super.key, required this.user});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(authControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio Usuario'),
        actions: [
          IconButton(onPressed: ctrl.signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                userAvatar(user.photoUrl, radius: 24),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName ?? '(sin nombre)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(user.email ?? user.uid),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Rol: ${user.role}'),
            const SizedBox(height: 8),
            const Text('JWT (ID token):'),
            SelectableText(user.idToken ?? '[cargando…]', maxLines: 6),
          ],
        ),
      ),
    );
  }
}
