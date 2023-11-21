import 'package:flutter/material.dart';
import 'package:snake_game/game/presentation/game_screen.dart';
import 'package:snake_game/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: {GameScreen.routeNamed: (context) => const GameScreen()},
    );
  }
}
