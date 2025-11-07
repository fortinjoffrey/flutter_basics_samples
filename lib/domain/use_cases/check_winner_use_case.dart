import 'package:tic_tac_toe_app/constants/winning_combinations.dart';
import 'package:tic_tac_toe_app/models/player.dart';

class CheckWinnerUseCase {
  GameResult execute(List<Player?> board) {
    final winningLine = _getWinningLine(board);

    if (winningLine != null) {
      final winner = board[winningLine.first];
      return GameResult.win(winner: winner!, winningLine: winningLine);
    }

    if (_isBoardFull(board)) {
      return const GameResult.draw();
    }

    return const GameResult.ongoing();
  }

  List<int>? _getWinningLine(List<Player?> board) {
    for (final combination in winningCombinations) {
      final a = board[combination[0]];
      final b = board[combination[1]];
      final c = board[combination[2]];

      if (a != null && a == b && b == c) {
        return combination;
      }
    }
    return null;
  }

  bool _isBoardFull(List<Player?> board) {
    return !board.any((cell) => cell == null);
  }
}

sealed class GameResult {
  const GameResult();

  const factory GameResult.win({
    required Player winner,
    required List<int> winningLine,
  }) = GameWin;

  const factory GameResult.draw() = GameDraw;

  const factory GameResult.ongoing() = GameOngoing;
}

class GameWin extends GameResult {
  final Player winner;
  final List<int> winningLine;

  const GameWin({
    required this.winner,
    required this.winningLine,
  });
}

class GameDraw extends GameResult {
  const GameDraw();
}

class GameOngoing extends GameResult {
  const GameOngoing();
}
