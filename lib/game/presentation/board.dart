import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameSate>(builder: (context, state) {
      return GridView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: ColoredBox(
              color: state.gridColors[index],
              child: Text('$index'),
            ),
            // child:Text('$index'),
            onTap: () {
              // context.read<GameBloc>().add(GameInitEvent(index: index));
            },
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 5,
          mainAxisSpacing: 6,
        ),
        physics: const NeverScrollableScrollPhysics(),
      );
    });
  }
}
