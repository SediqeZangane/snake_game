import 'package:snake_game/game/application/game_bloc.dart';

class GameState {
  final List<List<int>> board;
  final Position headPosition;
  final bool gameOver;

  const GameState({
    required this.board,
    required this.headPosition,
    required this.gameOver,
  });

  GameState.init()
      : board = List.generate(boardSize, (_) => List.filled(boardSize, 0)),
        headPosition = const Position(
          row: -1,
          column: -1,
        ),
        gameOver = false;

  GameState copyWith({
    List<List<int>>? board,
    Position? headPosition,
    bool? gameOver,
  }) {
    return GameState(
      board: board ?? this.board,
      headPosition: headPosition ?? this.headPosition,
      gameOver: gameOver ?? this.gameOver,
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
