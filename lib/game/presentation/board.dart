import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_state.dart';
import 'package:snake_game/shared/cell_type.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      return Column(
          children: state.board
              .map(
                (row) => Row(
                  children: row.map((cell) => buildCell(cell)).toList(),
                ),
              )
              .toList());
    });
  }

  Widget buildCell(int cell) {
    Color color;
    switch (toCellType(cell)) {
      case CellType.head:
        color = Colors.cyanAccent;
      case CellType.body:
        color = Colors.green;

      case CellType.tail:
        color = Colors.greenAccent;

      case CellType.seed:
        color = Colors.red;

      case CellType.empty:
        color = Colors.grey;
    }
    return SizedBox.square(dimension: 20, child: ColoredBox(color: color));
  }

  CellType toCellType(int num) {
    if (num == 1) {
      return CellType.tail;
    } else if (num > 0) {
      return CellType.body;
    } else if (num == -1) {
      return CellType.seed;
    }

    return CellType.empty;
  }
}
