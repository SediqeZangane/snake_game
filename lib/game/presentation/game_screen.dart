import 'package:flutter/material.dart';
import 'package:snake_game/game/presentation/arrows.dart';

class GameScreen extends StatefulWidget {
  static const String routeNamed = 'gameScreen';

  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            flex:2,
            child: Container(
                color: Colors.deepPurpleAccent
            ),
          ),
           const Expanded(
            flex: 1,
            child: Arrows(),
          ),
        ],
      ),
    ));
  }
}
