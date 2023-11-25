import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

class Arrows extends StatelessWidget {
  const Arrows({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Expanded(child: SizedBox()),
                buttonWidget(
                  Icons.arrow_circle_up_outlined,
                  () {
                    if (state.direction != Direction.up) {
                      context.read<GameBloc>().add(GameUpEvent());
                    }
                  },
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            Row(
              children: [
                buttonWidget(
                  Icons.arrow_circle_left_outlined,
                  () {
                    if (state.direction != Direction.left) {
                      context.read<GameBloc>().add(GameLeftEvent());
                    }
                  },
                ),
                const Expanded(child: SizedBox()),
                buttonWidget(
                  Icons.arrow_circle_right_outlined,
                  () {
                    if (state.direction != Direction.right) {
                      context.read<GameBloc>().add(GameRightEvent());
                    }
                  },
                )
              ],
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                buttonWidget(
                  Icons.arrow_circle_down_outlined,
                  () {
                    if (state.direction != Direction.down) {
                      context.read<GameBloc>().add(GameDownEvent());
                    }
                  },
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        );
      }),
    );
  }

  buttonWidget(IconData iconData, VoidCallback function) {
    return Expanded(
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          function.call();
        },
        icon: Icon(
          iconData,
          size: 85,
        ),
      ),
    );
  }
}
