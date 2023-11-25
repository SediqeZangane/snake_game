import 'package:snake_game/game/application/game_bloc.dart';

enum Direction { right, left, up, down }

class GameState {
  final List<List<int>> board;
  final Position headPosition;
  final bool gameOver;
  final int snakeHead;
  final Direction direction;

  const GameState({
    required this.board,
    required this.headPosition,
    required this.gameOver,
    required this.snakeHead,
    required this.direction,
  });

  int get score {
    return snakeHead - 2;
  }

  GameState.init()
      : board = List.generate(boardSize, (_) => List.filled(boardSize, 0)),
        headPosition = const Position(
          row: -1,
          column: -1,
        ),
        gameOver = false,
        snakeHead = 2,
        direction = Direction.right;

  GameState copyWith({
    List<List<int>>? board,
    Position? headPosition,
    bool? gameOver,
    int? snakeHead,
    Direction? direction,
  }) {
    return GameState(
      board: board ?? this.board,
      headPosition: headPosition ?? this.headPosition,
      gameOver: gameOver ?? this.gameOver,
      snakeHead: snakeHead ?? this.snakeHead,
      direction: direction ?? this.direction,
    );
  }
}

class Position {
  final int row;
  final int column;

  const Position({
    required this.row,
    required this.column,
  });
}
