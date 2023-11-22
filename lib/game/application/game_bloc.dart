import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

const boardSize = 16;

class GameBloc extends Bloc<GameEvent, GameSate> {
  GameBloc() : super(GameSate.init()) {
    on<GameEvent>((event, emit) {
      if (event is GameInitEvent) {}

      if (event is GameUpEvent) {}
    });
  }
}
