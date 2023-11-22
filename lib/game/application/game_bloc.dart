import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameSate> {
  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      if (event is GameInitEvent) {
      final head= Random().nextInt(99);
      final tail= head-1;

        emit(state.copyWith(snakeHead: head, snakeTail:tail));

        final listColors = getColors(state.snakeHead, state.snakeTail);

        emit(state.copyWith(gridColors: listColors));

        Timer.periodic(Duration(seconds: 1), (timer) {
          add(GameUpEvent());
        });
      }

      if (event is GameUpEvent) {
        if (((state.snakeHead) - (state.snakeTail) == 1)) {
          final newHead = (state.snakeHead) - 10;
          final newTail = (state.snakeTail) + 1;

          emit(state.copyWith(snakeHead: newHead, snakeTail: newTail));
        }
        if (((state.snakeHead) - (state.snakeTail) == -10)) {
          final newHead = (state.snakeHead) - 10;
          final newTail = (state.snakeTail) - 10;

          emit(state.copyWith(snakeHead: newHead, snakeTail: newTail));
        }

        final listColors = getColors(state.snakeHead, state.snakeTail);
        emit(state.copyWith(gridColors: listColors));
      }
    });
  }

  List<Color> getColors(int head, int tail) {
    final colors = List.generate(100, (index) => const Color(0xffb74093));
    colors[head] = Colors.green;
    colors[tail] = Colors.blue;
    colors[1] = Colors.white;
    return colors;
  }
}
