
import 'package:tic_tac_toe_app/models/difficulty.dart';
import 'package:tic_tac_toe_app/models/player.dart';

sealed class GameMode {
  const GameMode();
}

class AIMode extends GameMode {
  final Difficulty difficulty;
  final Player humanPlayer;

  const AIMode({
    required this.difficulty,
    required this.humanPlayer,
  });
}

class TwoPlayersMode extends GameMode {
  const TwoPlayersMode();
}

