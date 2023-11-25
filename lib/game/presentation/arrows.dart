import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/game/application/game_bloc.dart';
import 'package:snake_game/game/application/game_event.dart';
import 'package:snake_game/game/application/game_state.dart';

class Arrows extends StatefulWidget {
  const Arrows({super.key});

  @override
  State<Arrows> createState() => _ArrowsState();
}

class _ArrowsState extends State<Arrows> {
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
        return RawKeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              _handleKeyPressed(event, state);
            }
          },
          child: Column(
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
          ),
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
        icon: Builder(builder: (context) {
          return Icon(
            iconData,
            size: MediaQuery.of(context).size.height / 10,
          );
        }),
      ),
    );
  }

  void _handleKeyPressed(RawKeyDownEvent event, GameState state) {
    if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      if (state.direction != Direction.down) {
        context.read<GameBloc>().add(GameDownEvent());
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      if (state.direction != Direction.up) {
        context.read<GameBloc>().add(GameUpEvent());
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      if (state.direction != Direction.right) {
        context.read<GameBloc>().add(GameRightEvent());
      }
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      if (state.direction != Direction.left) {
        context.read<GameBloc>().add(GameLeftEvent());
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
