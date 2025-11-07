import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/player.dart';

abstract class GameEvent {
  const GameEvent();
}

class CellTappedEvent extends GameEvent {
  final int index;

  const CellTappedEvent(this.index);
}

class RestartGameEvent extends GameEvent {
  const RestartGameEvent();
}

class ResetScoresEvent extends GameEvent {
  const ResetScoresEvent();
}

class DismissWinnerScreenEvent extends GameEvent {
  const DismissWinnerScreenEvent();
}

class SelectStartingPlayerEvent extends GameEvent {
  final Player player;

  const SelectStartingPlayerEvent(this.player);
}

class SelectGameModeEvent extends GameEvent {
  final GameMode gameMode;

  const SelectGameModeEvent(this.gameMode);
}

class ChangeGameModeEvent extends GameEvent {
  final GameMode gameMode;

  const ChangeGameModeEvent(this.gameMode);
}

class AIPlayEvent extends GameEvent {
  const AIPlayEvent();
}

class ShowWinnerScreenEvent extends GameEvent {
  const ShowWinnerScreenEvent();
}

class StartAIGameEvent extends GameEvent {
  const StartAIGameEvent();
}
