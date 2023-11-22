import 'package:snake_game/game/application/game_bloc.dart';

class GameSate {
  final List<List<int>> board;
  final Position headPosition;

  const GameSate({
    required this.board,
    required this.headPosition,
  });

  GameSate.init()
      : board = List.generate(boardSize, (_) => List.filled(boardSize, 0)),
        headPosition = const Position(row: -1, column: -1);

  GameSate copyWith({
    List<List<int>>? board,
    Position? headPosition,
  }) {
    return GameSate(
      board: board ?? this.board,
      headPosition: headPosition ?? this.headPosition,
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
