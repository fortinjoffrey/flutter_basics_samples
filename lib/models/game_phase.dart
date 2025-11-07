import 'package:tic_tac_toe_app/models/player.dart';

sealed class GamePhase {
  const GamePhase();
}

class NotStarted extends GamePhase {
  final Player selectedPlayer;

  const NotStarted({required this.selectedPlayer});
}

class Playing extends GamePhase {
  final List<Player?> board;
  final Player currentPlayer;

  const Playing({
    required this.board,
    required this.currentPlayer,
  });
}

class Finished extends GamePhase {
  final List<Player?> board;
  final Player? winner;
  final List<int>? winningLine;
  final bool showWinnerScreen;

  const Finished({
    required this.board,
    required this.winner,
    required this.winningLine,
    this.showWinnerScreen = false,
  });
}
