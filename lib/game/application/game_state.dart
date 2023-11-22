import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/shared/cell_type.dart';

class GameSate {
  final List<List<CellType>> board;

  const GameSate({
    required this.board,
  });

  GameSate.init()
      : board = List.generate(
            boardSize, (_) => List.filled(boardSize, CellType.empty));

  GameSate copyWith({
    List<List<CellType>>? board,
  }) {
    return GameSate(
      board: board ?? this.board,
    );
  }
}
