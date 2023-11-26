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
      return ColoredBox(
        color: Colors.deepPurpleAccent.shade100,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: state.board
                .map(
                  (row) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: row
                        .map((cell) =>
                            buildImageCell(cell, state.snakeHead, state))
                        .toList(),
                  ),
                )
                .toList()),
      );
    });
  }

  Widget buildCell(int cell, int snakeHead) {
    Color color;
    switch (toCellType(cell, snakeHead)) {
      case CellType.head:
        color = Colors.cyanAccent;
      case CellType.body:
        color = Colors.green;

      case CellType.tail:
        color = Colors.greenAccent;

      case CellType.seed:
        color = Colors.red;

      case CellType.empty:
        color = Colors.transparent;
    }
    return Builder(builder: (context) {
      return SizedBox.square(
        dimension: MediaQuery.of(context).size.height / 40,
        child: ColoredBox(color: color),
      );
    });
  }

  Widget buildImageCell(int cell, int snakeHead, GameState state) {
    String? imagePath;
    switch (toCellType(cell, snakeHead)) {
      case CellType.head:
        imagePath = getHead(state);
      case CellType.body:
        imagePath = 'assets/body_vertical.png';
      case CellType.tail:
        imagePath = 'assets/tail_up.png';
      case CellType.seed:
        imagePath = 'assets/apple.png';
      case CellType.empty:
    }
    return Builder(builder: (context) {
      return SizedBox.square(
        dimension: MediaQuery.of(context).size.height / 40,
        child: imagePath != null ? Image.asset(imagePath) : const SizedBox(),
      );
    });
  }

  CellType toCellType(int num, int snakeHead) {
    if (num == 1) {
      return CellType.tail;
    } else if (num == snakeHead) {
      return CellType.head;
    } else if (num > 0) {
      return CellType.body;
    } else if (num == -1) {
      return CellType.seed;
    }

    return CellType.empty;
  }

  String getHead(GameState state) {
    switch (state.direction) {
      case Direction.right:
        return 'assets/head_right.png';
      case Direction.left:
        return 'assets/head_left.png';
      case Direction.up:
        return 'assets/head_up.png';
      case Direction.down:
        return 'assets/head_down.png';
    }
  }
}
