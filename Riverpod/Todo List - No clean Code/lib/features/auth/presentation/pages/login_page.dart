import 'package:flutter/material.dart';
import 'package:flutter_config_minima/core/utils/utils.dart';
import 'package:flutter_config_minima/features/auth/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authProvider);
    final loading = userAsync.isLoading;
    showSnackbarLogin(ref, context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pwd,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (v) => (v != null && v.length >= 4)
                          ? null
                          : 'Mínimo 4 chars',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(authProvider.notifier)
                                      .login(_email.text, _pwd.text);
                                }
                              },
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Text('Entrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
