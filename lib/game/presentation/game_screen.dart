import 'package:flutter/material.dart';
import 'package:snake_game/game/presentation/arrows.dart';
import 'package:snake_game/game/presentation/board.dart';

class GameScreen extends StatefulWidget {
  static const String routeNamed = 'gameScreen';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3, child: Board()),
          Expanded(flex: 2, child: Arrows()),
        ],
      ),
    ));
  }
}
