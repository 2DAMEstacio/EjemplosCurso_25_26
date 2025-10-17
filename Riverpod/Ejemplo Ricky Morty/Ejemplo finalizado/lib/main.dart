import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_ejemplo/presentation/providers/fav_characters_provider.dart';
import 'package:flutter_riverpod_ejemplo/presentation/screens/favourite_characters.dart';
import 'package:flutter_riverpod_ejemplo/presentation/widgets/character_list.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      home: const MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key, required String title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteCharacters(),
                    ),
                  );
                },
                icon: Badge.count(
                  count: ref.watch(favCharacterProvider).length,
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/ricky_logo.png'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: CharacterList(),
    );
  }
}
