import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/favourite_characters.dart';
import 'package:flutter_application_1/presentation/widgets/characters_list.dart';

void main() {
  runApp(MyApp());
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
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
                  count: 0,
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/ricky_logo.png'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: CharactersList(),
    );
  }
}
