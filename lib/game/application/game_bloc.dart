import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

const boardSize = 10;

enum Direction { right, left, up, down }

class GameBloc extends Bloc<GameEvent, GameState> {
  int snakeHead = 2;
  Direction direction = Direction.right;

  GameBloc() : super(GameState.init()) {
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
            case Direction.right:
              add(GameRightEvent());
              break;
            case Direction.left:
              add(GameLeftEvent());
              break;
            case Direction.up:
              add(GameUpEvent());
              break;
            case Direction.down:
              add(GameDownEvent());
              break;
          }
        });
      }
      if (event is MoveEvent) {
        int nextRow = -1;
        int nextColumn = -1;

        if (event is GameRightEvent) {
          if (direction == Direction.left) {
            return;
          }
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column + 1;
          if (nextColumn == boardSize) {
            nextColumn = 0;
          }
          direction = Direction.right;
        } else if (event is GameLeftEvent) {
          if (direction == Direction.right) {
            return;
          }
          nextRow = state.headPosition.row;
          nextColumn = state.headPosition.column - 1;
          if (nextColumn == -1) {
            nextColumn = boardSize - 1;
          }
          direction = Direction.left;
        } else if (event is GameUpEvent) {
          if (direction == Direction.down) {
            return;
          }
          nextRow = state.headPosition.row - 1;
          if (nextRow == -1) {
            nextRow = boardSize - 1;
          }
          nextColumn = state.headPosition.column;
          direction = Direction.up;
        } else if (event is GameDownEvent) {
          if (direction == Direction.up) {
            return;
          }
          nextRow = state.headPosition.row + 1;
          if (nextRow == boardSize) {
            nextRow = 0;
          }
          nextColumn = state.headPosition.column;
          direction = Direction.down;
        }

        final nextCell = board[nextRow][nextColumn];

        if (nextCell > 0) {
          emit(state.copyWith(gameOver: true));
        } else {
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
