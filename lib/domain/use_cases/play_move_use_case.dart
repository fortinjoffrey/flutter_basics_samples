import 'package:tic_tac_toe_app/models/player.dart';

class PlayMoveUseCase {
  PlayMoveResult execute({
    required List<Player?> board,
    required int index,
    required Player currentPlayer,
  }) {
    if (board[index] != null) {
      return PlayMoveResult.invalidMove('Case déjà occupée');
    }

    final newBoard = List<Player?>.from(board);
    newBoard[index] = currentPlayer;

    return PlayMoveResult.success(
      board: newBoard,
      nextPlayer: _getNextPlayer(currentPlayer),
    );
  }

  Player _getNextPlayer(Player player) {
    return player == Player.x ? Player.o : Player.x;
  }
}

sealed class PlayMoveResult {
  const PlayMoveResult();

  factory PlayMoveResult.success({
    required List<Player?> board,
    required Player nextPlayer,
  }) = PlayMoveSuccess;

  factory PlayMoveResult.invalidMove(String reason) = PlayMoveInvalid;
}

class PlayMoveSuccess extends PlayMoveResult {
  final List<Player?> board;
  final Player nextPlayer;

  const PlayMoveSuccess({
    required this.board,
    required this.nextPlayer,
  });
}

class PlayMoveInvalid extends PlayMoveResult {
  final String reason;

  const PlayMoveInvalid(this.reason);
}
