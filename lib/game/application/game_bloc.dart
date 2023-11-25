import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

const boardSize = 18;

enum Direction { Right, Left, Up, Down }

class GameBloc extends Bloc<GameEvent, GameSate> {
  int snakeHead = 2;
  Direction direction = Direction.Right;

  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      final board = state.board;
      if (event is GameInitEvent) {
        seedPosition(board);

        final rowHead = randomInt();
        final columnHead = randomInt();
        board[rowHead][columnHead] = snakeHead;

        board[rowHead][columnHead - 1] = 1;

        emit(state.copyWith(
            board: board,
            headPosition: Position(row: rowHead, column: columnHead)));
        Timer.periodic(const Duration(milliseconds: 200), (timer) {
          switch (direction) {
            case Direction.Right:
              add(GameRightEvent());
              break;
            case Direction.Left:
              add(GameLeftEvent());
              break;
            case Direction.Up:
              add(GameUpEvent());
              break;
            case Direction.Down:
              add(GameDownEvent());
              break;
          }
        });
      }
      if (event is MoveEvent) {
        int nextRow = -1;
        int nextColumn = -1;
        if (event is GameRightEvent) {
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column + 1;
          if (nextColumn == boardSize) {
            nextColumn = 0;
          }
          direction = Direction.Right;
        } else if (event is GameLeftEvent) {
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column - 1;
          if (nextColumn == -1) {
            nextColumn = boardSize - 1;
          }
          direction = Direction.Left;
        } else if (event is GameUpEvent) {
          nextRow = state.headPosition.row - 1;
          if (nextRow == -1) {
            nextRow = boardSize - 1;
          }
          nextColumn = state.headPosition.column;
          direction = Direction.Up;
        } else if (event is GameDownEvent) {
          nextRow = state.headPosition.row + 1;
          if (nextRow == boardSize) {
            nextRow = 0;
          }
          nextColumn = state.headPosition.column;
          direction = Direction.Down;
        }

        final isNextSeed = board[nextRow][nextColumn] == -1;

        board[nextRow][nextColumn] = snakeHead + 1;
        emit(state.copyWith(
            headPosition: Position(row: nextRow, column: nextColumn)));

        if (isNextSeed) {
          snakeHead = snakeHead + 1;
          seedPosition(board);
        } else {
          moveBody(board);
        }

        emit(state.copyWith(board: board));
      }
    });
  }

  void seedPosition(List<List<int>> board) {
    final row = randomInt();
    final column = randomInt();
    var cellType = board[row][column];
    if (cellType == 0) {
      board[row][column] = -1;
    } else {
      seedPosition(board);
    }
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
