abstract class GameEvent {}

class GameInitEvent implements GameEvent {}

class MoveEvent implements GameEvent {}

class GameRightEvent implements MoveEvent {}

class GameUpEvent implements MoveEvent {}

class GameDownEvent implements MoveEvent {}

class GameLeftEvent implements MoveEvent {}
