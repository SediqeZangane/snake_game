import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';
import 'package:snake_game/shared/cell_type.dart';

const boardSize = 16;

class GameBloc extends Bloc<GameEvent, GameSate> {
  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      if (event is GameInitEvent) {
        state.board[randomInt()][randomInt()] = CellType.seed;
        final rowHead=randomInt();
        final columnHead=randomInt();
        state.board[rowHead][columnHead] = CellType.head;
        state.board[rowHead][columnHead-1] = CellType.tail;

        emit(state);
      }

      if (event is GameUpEvent) {}
    });
  }

  int randomInt() {
    return Random().nextInt(boardSize-1);
  }
}
