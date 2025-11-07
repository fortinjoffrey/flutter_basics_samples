import 'dart:math';
import 'package:tic_tac_toe_app/constants/winning_combinations.dart';
import 'package:tic_tac_toe_app/models/difficulty.dart';
import 'package:tic_tac_toe_app/models/player.dart';

class AIPlayerService {
  static int getMoveIndex({
    required List<Player?> board,
    required Difficulty difficulty,
    required Player aiPlayer,
  }) {
    return switch (difficulty) {
      Difficulty.easy => _getEasyMoveIndex(board),
      Difficulty.medium => _getMediumMoveIndex(board, aiPlayer),
      Difficulty.impossible => _getImpossibleMoveIndex(board, aiPlayer),
    };
  }

  /// Mode facile : choisit un coup aléatoire parmi les cases vides
  static int _getEasyMoveIndex(List<Player?> board) {
    final availableMoves = _getAvailableMoves(board);
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  /// Mode moyen : essaie de gagner ou bloquer l'adversaire 50% du temps,
  /// sinon joue aléatoirement (pour ne pas être trop prévisible)
  static int _getMediumMoveIndex(List<Player?> board, Player aiPlayer) {
    // 50% du temps, jouer stratégiquement
    if (Random().nextBool()) {
      // D'abord, chercher un coup gagnant
      final winMove = _findWinningMoveIndex(board, aiPlayer);
      if (winMove != null) return winMove;

      // Sinon, bloquer l'adversaire s'il peut gagner
      final opponent = _getOpponent(aiPlayer);
      final blockMove = _findWinningMoveIndex(board, opponent);
      if (blockMove != null) return blockMove;
    }

    // 50% du temps (ou si pas de coup stratégique), jouer aléatoirement
    return _getEasyMoveIndex(board);
  }

  /// Mode impossible : utilise l'algorithme Minimax pour jouer le coup optimal
  /// Cet algorithme explore TOUS les coups possibles jusqu'à la fin de la partie
  static int _getImpossibleMoveIndex(List<Player?> board, Player aiPlayer) {
    // 🎯 OPTIMISATION : Si le board est vide, jouer un coup optimal aléatoire
    // Évite ~550k simulations et rend le jeu moins prévisible
    if (board.every((cell) => cell == null)) {
      // Centre (case 4) + 4 coins (0, 2, 6, 8) sont les coups optimaux
      // Les bords (1, 3, 5, 7) sont sous-optimaux et exclus
      const optimalStartMoves = [4, 0, 2, 6, 8];
      return optimalStartMoves[Random().nextInt(optimalStartMoves.length)];
    }

    // Sinon, utiliser Minimax normalement
    // -1000 est juste une valeur très négative pour initialiser
    // (n'importe quelle valeur < -10 fonctionnerait)
    int bestScore = -1000;
    int bestMove = -1;

    // Tester chaque coup possible
    for (final move in _getAvailableMoves(board)) {
      // Simuler le coup (on modifie temporairement le board)
      board[move] = aiPlayer;
      // Calculer le score de ce coup en explorant tous les coups futurs
      final score = _minimax(board, 0, false, aiPlayer);
      // IMPORTANT : remettre le board comme avant (annuler la simulation)
      board[move] = null;

      // Garder le meilleur coup trouvé
      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }

    return bestMove;
  }

  /// Algorithme Minimax : explore récursivement tous les coups possibles
  ///
  /// Scores :
  /// - +10 : L'IA gagne (moins la profondeur pour préférer les victoires rapides)
  /// - -10 : L'adversaire gagne (plus la profondeur pour retarder la défaite)
  /// -  0 : Match nul
  ///
  /// Les valeurs ±1000 sont juste des valeurs initiales très grandes pour
  /// s'assurer que n'importe quel score réel (-10 à +10) sera meilleur
  ///
  /// [depth] : profondeur actuelle dans l'arbre de recherche
  /// [isMaximizing] : true si c'est le tour de l'IA (cherche à maximiser le score)
  static int _minimax(
    List<Player?> board,
    int depth,
    bool isMaximizing,
    Player aiPlayer,
  ) {
    // Conditions de fin : quelqu'un a gagné ou plateau plein
    final winner = _checkWinner(board);
    if (winner == aiPlayer) return 10 - depth; // IA gagne (victoire rapide = mieux)
    if (winner != null) return depth - 10; // Adversaire gagne (défaite lente = moins pire)
    if (_isBoardFull(board)) return 0; // Match nul

    if (isMaximizing) {
      // Tour de l'IA : chercher le meilleur score (maximiser)
      int bestScore = -1000; // Commence très bas
      for (final move in _getAvailableMoves(board)) {
        board[move] = aiPlayer; // Simuler le coup
        final score = _minimax(board, depth + 1, false, aiPlayer); // Explorer
        board[move] = null; // Annuler la simulation
        bestScore = max(bestScore, score);
      }
      return bestScore;
    } else {
      // Tour de l'adversaire : chercher le pire score pour l'IA (minimiser)
      int bestScore = 1000; // Commence très haut
      final opponent = _getOpponent(aiPlayer);
      for (final move in _getAvailableMoves(board)) {
        board[move] = opponent; // Simuler le coup de l'adversaire
        final score = _minimax(board, depth + 1, true, aiPlayer); // Explorer
        board[move] = null; // Annuler la simulation
        bestScore = min(bestScore, score);
      }
      return bestScore;
    }
  }

  /// Trouve un coup qui permet de gagner immédiatement, s'il existe
  static int? _findWinningMoveIndex(List<Player?> board, Player player) {
    for (final move in _getAvailableMoves(board)) {
      // Simuler le coup
      board[move] = player;
      final isWinning = _checkWinner(board) == player;
      // Annuler la simulation
      board[move] = null;

      if (isWinning) return move;
    }
    return null;
  }

  static Player? _checkWinner(List<Player?> board) {
    for (final combo in winningCombinations) {
      final a = board[combo[0]];
      final b = board[combo[1]];
      final c = board[combo[2]];
      if (a != null && a == b && b == c) return a;
    }
    return null;
  }

  static List<int> _getAvailableMoves(List<Player?> board) {
    return List.generate(9, (i) => i).where((i) => board[i] == null).toList();
  }

  static bool _isBoardFull(List<Player?> board) {
    return !board.any((cell) => cell == null);
  }

  static Player _getOpponent(Player player) {
    return player == Player.x ? Player.o : Player.x;
  }
}
