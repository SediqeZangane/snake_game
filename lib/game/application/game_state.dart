import 'dart:ui';

class GameSate {
  final List<Color> gridColors;
  final int snakeTail;
  final int snakeHead;

  const GameSate({
    required this.gridColors,
    required this.snakeTail,
    required this.snakeHead,
  });

  GameSate.init()
      : gridColors = List.generate(100, (index) => const Color(0xffb74093)),
        snakeTail = 0,
        snakeHead = 0;

  GameSate copyWith({
    List<Color>? gridColors,
    int? snakeTail,
    int? snakeHead,
  }) {
    return GameSate(
      gridColors: gridColors ?? this.gridColors,
      snakeTail: snakeTail ?? this.snakeTail,
      snakeHead: snakeHead ?? this.snakeHead,
    );
  }
}
