import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';
import 'package:snake_game/shared/cell_type.dart';

const boardSize = 16;

class GameBloc extends Bloc<GameEvent, GameSate> {
  final snakeHead = 2;

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

      if (event is GameRightEvent) {
        board[state.headPosition.row][state.headPosition.column + 1] =
            snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(
                row: state.headPosition.row,
                column: state.headPosition.column + 1)));

        moveBody(board);

        emit(state.copyWith(board: board));
      }

      if (event is GameUpEvent) {
        board[state.headPosition.row - 1][state.headPosition.column] =
            snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(
                row: state.headPosition.row - 1,
                column: state.headPosition.column)));
        moveBody(board);
        emit(state.copyWith(board: board));
      }

      if (event is GameDownEvent) {
        board[state.headPosition.row + 1][state.headPosition.column] =
            snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(
                row: state.headPosition.row + 1,
                column: state.headPosition.column)));
        moveBody(board);
        emit(state.copyWith(board: board));
      }

      if (event is GameLeftEvent) {
        board[state.headPosition.row][state.headPosition.column - 1] =
            snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(
                row: state.headPosition.row,
                column: state.headPosition.column - 1)));
        moveBody(board);
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
