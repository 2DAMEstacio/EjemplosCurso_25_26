import 'package:flutter/material.dart';
import 'package:flutter_login_google/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(authControllerProvider.notifier);
    final authAsync = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min, // <-- evita que se expanda
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Título
                  const Text(
                    'Iniciar sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Email
                  TextFormField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Introduce tu email' : null,
                  ),
                  const SizedBox(height: 12),

                  // Contraseña
                  TextFormField(
                    controller: _pwdCtrl,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _obscure = !_obscure),
                        icon: Icon(
                          _obscure ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (v) => (v == null || v.length < 6)
                        ? 'Mínimo 6 caracteres'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(
                        onPressed: authAsync.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await ctrl.signInWithEmailPassword(
                                    _emailCtrl.text,
                                    _pwdCtrl.text,
                                  );
                                }
                              },
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: authAsync.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  await ctrl.registerWithEmailPassword(
                                    _emailCtrl.text,
                                    _pwdCtrl.text,
                                  );
                                }
                              },
                        child: const Text('Crear cuenta'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: authAsync.isLoading
                        ? null
                        : () async {
                            final email = _emailCtrl.text.trim();
                            final messenger = ScaffoldMessenger.of(context);

                            if (email.isNotEmpty) {
                              await ctrl.sendPasswordReset(email);
                              if (!mounted) return;
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Email de recuperación enviado',
                                  ),
                                ),
                              );
                            } else {
                              if (!mounted) return;
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Introduce tu email primero'),
                                ),
                              );
                            }
                          },
                    child: const Text('¿Olvidaste tu contraseña?'),
                  ),
                  const SizedBox(height: 10),

                  // Separador
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('o'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Login con Google
                  FilledButton.icon(
                    onPressed: () => ctrl.signInWithGoogle(),
                    icon: const Icon(Icons.login),
                    label: const Text('Entrar con Google'),
                  ),

                  if (authAsync.hasError) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${authAsync.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
