import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_google/features/auth/controller/auth_controller.dart';
import 'package:flutter_login_google/features/auth/presentation/pages/admin_home.dart';
import 'package:flutter_login_google/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter_login_google/features/auth/presentation/pages/user_home.dart';
import 'package:flutter_login_google/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FirebaseAuth + Riverpod',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color.fromARGB(255, 181, 126, 63),
      ),
      home: authAsync.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) =>
            Scaffold(body: Center(child: Text('Error: ${e.toString()}'))),
        data: (user) {
          if (user == null) return const LoginScreen();
          if (user.isAdmin) return AdminHome(user: user);
          return UserHome(user: user);
        },
      ),
    );
  }
}
