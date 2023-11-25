import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';
import 'package:snake_game/game/presentation/arrows.dart';
import 'package:snake_game/game/presentation/board.dart';
import 'package:snake_game/home/presentation/home_screen.dart';

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
      body: BlocListener<GameBloc, GameState>(
        listener: (BuildContext context, state) {
          if (state.gameOver) {
            gameOverDialog(context);
          }
        },
        child: const Column(
          children: [
            Expanded(flex: 3, child: Board()),
            Expanded(flex: 2, child: Arrows()),
          ],
        ),
      ),
    ));
  }

  void gameOverDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Game Over'),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<GameBloc>().add(GameInitEvent());
              },
            ),
            TextButton(
              child: const Text('Back'),
              onPressed: () {
                Navigator.of(context).popUntil(
                    (route) => route.settings.name == HomeScreen.routeNamed);
              },
            ),
          ],
        );
      },
    );
  }
}
