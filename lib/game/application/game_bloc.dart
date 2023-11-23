import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

const boardSize = 16;

class GameBloc extends Bloc<GameEvent, GameSate> {
  int snakeHead = 2;

  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      final board = state.board;
      if (event is GameInitEvent) {
        board[randomInt()][randomInt()] = -1;
        final rowHead = randomInt();
        final columnHead = randomInt();
        board[rowHead][columnHead] = snakeHead;

        board[rowHead][columnHead - 1] = 1;

        emit(state.copyWith(
            board: board,
            headPosition: Position(row: rowHead, column: columnHead)));
      }

      if (event is MoveEvent) {
        int nextRow = -1;
        int nextColumn = -1;
        if (event is GameRightEvent) {
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column + 1;
        } else if (event is GameLeftEvent) {
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column - 1;
        } else if (event is GameUpEvent) {
          nextRow = state.headPosition.row - 1;
          nextColumn = state.headPosition.column;
        } else if (event is GameDownEvent) {
          nextRow = state.headPosition.row + 1;
          nextColumn = state.headPosition.column;
        }

        final isNextSeed = board[nextRow][nextColumn] == -1;

        board[nextRow][nextColumn] = snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(row: nextRow, column: nextColumn)));

        if (isNextSeed) {
          snakeHead = snakeHead + 1;
          board[randomInt()][randomInt()] = -1;
        } else {
          moveBody(board);
        }

        emit(state.copyWith(board: board));
      }
    });
  }

  int randomInt() {
    return Random().nextInt(boardSize - 1);
  }

  void moveBody(List<List<int>> board) {
    for (int i = 0; i < board.length; i++) {
      final row = board[i];
      for (int j = 0; j < row.length; j++) {
        if (board[i][j] > 0) {
          board[i][j] = board[i][j] - 1;
        }
      }
    }
  }
}
