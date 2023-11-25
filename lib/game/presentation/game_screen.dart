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
      body: BlocConsumer<GameBloc, GameState>(
          listener: (BuildContext context, state) {
        if (state.gameOver) {
          gameOverDialog(context, state);
        }
      }, builder: (BuildContext context, state) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Score : ${state.score}',
                style: const TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
              )),
            ),
            const Expanded(flex: 6, child: Center(child: Board())),
            const Expanded(flex: 5, child: Arrows()),
          ],
        );
      }),
    ));
  }

  void gameOverDialog(BuildContext context, GameState state) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Game Over',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Your score is ${state.score}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
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
