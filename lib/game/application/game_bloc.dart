import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';
import 'package:snake_game/shared/cell_type.dart';

const boardSize = 16;

class GameBloc extends Bloc<GameEvent, GameSate> {
  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      final board = state.board;
      if (event is GameInitEvent) {
        board[randomInt()][randomInt()] = CellType.seed;
        final rowHead = randomInt();
        final columnHead = randomInt();
        board[rowHead][columnHead] = CellType.head;
        board[rowHead][columnHead - 1] = CellType.tail;

        emit(state.copyWith(board: board));
      }

      if (event is GameRightEvent) {
        final indexes = board.map((e) => e.indexOf(CellType.head)).toList();
        final rowIndex = indexes.indexWhere((element) => element != -1);
        final columnIndex = indexes[rowIndex];

        board[rowIndex][columnIndex] = CellType.empty;
        board[rowIndex][columnIndex + 1] = CellType.head;
        emit(state.copyWith(board: board));
      }
    });
  }

  int randomInt() {
    return Random().nextInt(boardSize - 1);
  }
}
