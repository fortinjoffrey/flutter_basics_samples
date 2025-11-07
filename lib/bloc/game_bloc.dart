import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_event.dart';
import 'package:tic_tac_toe_app/constants/game_constants.dart';
import 'package:tic_tac_toe_app/constants/winning_combinations.dart';
import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/game_phase.dart';
import 'package:tic_tac_toe_app/models/game_state.dart';
import 'package:tic_tac_toe_app/models/player.dart';
import 'package:tic_tac_toe_app/services/ai_player_service.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(const GameState(
          xWinCount: 0,
          oWinCount: 0,
          phase: NotStarted(selectedPlayer: Player.x),
          gameMode: TwoPlayersMode(),
        )) {
    on<CellTappedEvent>(_onCellTapped);
    on<RestartGameEvent>(_onRestartGame);
    on<ResetScoresEvent>(_onResetScores);
    on<DismissWinnerScreenEvent>(_onDismissWinnerScreen);
    on<SelectStartingPlayerEvent>(_onSelectStartingPlayer);
    on<SelectGameModeEvent>(_onSelectGameMode);
    on<ChangeGameModeEvent>(_onChangeGameMode);
    on<AIPlayEvent>(_onAIPlay);
    on<ShowWinnerScreenEvent>(_onShowWinnerScreen);
    on<StartAIGameEvent>(_onStartAIGame);
  }

  Future<void> _onCellTapped(
    CellTappedEvent event,
    Emitter<GameState> emit,
  ) async {
    switch (state.phase) {
      case NotStarted(:final selectedPlayer):
        _startGame(event.index, selectedPlayer, emit);
      case Playing(:final board, :final currentPlayer):
        _playMove(event.index, board, currentPlayer, emit);
      case Finished():
        break;
    }
  }

  void _startGame(int index, Player selectedPlayer, Emitter<GameState> emit) {
    final board = List<Player?>.filled(9, null);
    board[index] = selectedPlayer;
    final nextPlayer = _getNextPlayer(selectedPlayer);
    emit(state.copyWith(
      phase: Playing(
        board: board,
        currentPlayer: nextPlayer,
      ),
    ));

    if (_isAIMode() && nextPlayer == _getAIPlayer()) {
      Future.delayed(const Duration(milliseconds: kAIPlayDelayMs), () {
        add(const AIPlayEvent());
      });
    }
  }

  void _onStartAIGame(
    StartAIGameEvent event,
    Emitter<GameState> emit,
  ) {
    if (state.phase is! NotStarted) return;

    final notStarted = state.phase as NotStarted;
    final aiPlayer = notStarted.selectedPlayer;
    final board = List<Player?>.filled(9, null);
    final mode = state.gameMode;
    if (mode is! AIMode) return;

    final aiMove = AIPlayerService.getMoveIndex(
      board: board,
      difficulty: mode.difficulty,
      aiPlayer: aiPlayer,
    );

    board[aiMove] = aiPlayer;
    final nextPlayer = _getNextPlayer(aiPlayer);

    emit(state.copyWith(
      phase: Playing(
        board: board,
        currentPlayer: nextPlayer,
      ),
    ));
  }

  void _playMove(
    int index,
    List<Player?> board,
    Player currentPlayer,
    Emitter<GameState> emit,
  ) {
    if (board[index] != null) return;

    final newBoard = List<Player?>.from(board);
    newBoard[index] = currentPlayer;

    final winningLine = _getWinningLine(newBoard);

    if (winningLine != null) {
      _handleWin(currentPlayer, winningLine, newBoard, emit);
    } else if (_isBoardFull(newBoard)) {
      _handleDraw(newBoard, emit);
    } else {
      _continueGame(newBoard, currentPlayer, emit);
    }
  }

  void _handleWin(
    Player winner,
    List<int> winningLine,
    List<Player?> board,
    Emitter<GameState> emit,
  ) {
    final newXWinCount = winner == Player.x ? state.xWinCount + 1 : state.xWinCount;
    final newOWinCount = winner == Player.o ? state.oWinCount + 1 : state.oWinCount;

    emit(state.copyWith(
      xWinCount: newXWinCount,
      oWinCount: newOWinCount,
      phase: Finished(
        board: board,
        winner: winner,
        winningLine: winningLine,
        showWinnerScreen: false,
      ),
    ));

    Future.delayed(const Duration(milliseconds: kShowWinnerScreenDelayMs), () {
      add(const ShowWinnerScreenEvent());
    });
  }

  void _handleDraw(List<Player?> board, Emitter<GameState> emit) {
    emit(state.copyWith(
      phase: Finished(
        board: board,
        winner: null,
        winningLine: null,
        showWinnerScreen: false,
      ),
    ));

    Future.delayed(const Duration(milliseconds: kShowWinnerScreenDelayMs), () {
      add(const ShowWinnerScreenEvent());
    });
  }

  void _continueGame(List<Player?> board, Player currentPlayer, Emitter<GameState> emit) {
    final nextPlayer = _getNextPlayer(currentPlayer);
    emit(state.copyWith(
      phase: Playing(
        board: board,
        currentPlayer: nextPlayer,
      ),
    ));

    if (_isAIMode() && nextPlayer == _getAIPlayer()) {
      Future.delayed(const Duration(milliseconds: kAIPlayDelayMs), () {
        add(const AIPlayEvent());
      });
    }
  }

  Player _getNextPlayer(Player player) {
    return player == Player.x ? Player.o : Player.x;
  }

  bool _isAIMode() {
    return state.gameMode is AIMode;
  }

  Player _getAIPlayer() {
    final mode = state.gameMode;
    if (mode is AIMode) {
      return mode.humanPlayer == Player.x ? Player.o : Player.x;
    }
    throw StateError('_getAIPlayer called in non-AI mode');
  }

  void _onRestartGame(
    RestartGameEvent event,
    Emitter<GameState> emit,
  ) {
    final currentStartingPlayer = switch (state.phase) {
      NotStarted(:final selectedPlayer) => selectedPlayer,
      Playing(:final board) => _getFirstPlayer(board),
      Finished(:final board) => _getFirstPlayer(board),
    };
    final nextStartingPlayer = _getNextPlayer(currentStartingPlayer);

    emit(state.copyWith(
      phase: NotStarted(selectedPlayer: nextStartingPlayer),
    ));

    if (_isAIMode() && nextStartingPlayer == _getAIPlayer()) {
      Future.delayed(const Duration(milliseconds: kGameStartDelayMs), () {
        add(const StartAIGameEvent());
      });
    }
  }

  Player _getFirstPlayer(List<Player?> board) {
    final xCount = board.where((p) => p == Player.x).length;
    final oCount = board.where((p) => p == Player.o).length;
    return xCount > oCount ? Player.x : Player.o;
  }

  void _onResetScores(
    ResetScoresEvent event,
    Emitter<GameState> emit,
  ) {
    emit(GameState(
      xWinCount: 0,
      oWinCount: 0,
      phase: const NotStarted(selectedPlayer: Player.x),
      gameMode: state.gameMode,
    ));
  }

  void _onDismissWinnerScreen(
    DismissWinnerScreenEvent event,
    Emitter<GameState> emit,
  ) {
    if (state.phase is Finished) {
      final finished = state.phase as Finished;
      final currentStartingPlayer = _getFirstPlayer(finished.board);
      final nextStartingPlayer = _getNextPlayer(currentStartingPlayer);

      emit(state.copyWith(
        phase: NotStarted(selectedPlayer: nextStartingPlayer),
      ));

      if (_isAIMode() && nextStartingPlayer == _getAIPlayer()) {
        Future.delayed(const Duration(milliseconds: kDismissWinnerDelayMs), () {
          add(const StartAIGameEvent());
        });
      }
    }
  }

  void _onSelectStartingPlayer(
    SelectStartingPlayerEvent event,
    Emitter<GameState> emit,
  ) {
    if (state.phase is NotStarted) {
      emit(state.copyWith(
        phase: NotStarted(selectedPlayer: event.player),
      ));
    }
  }

  void _onSelectGameMode(
    SelectGameModeEvent event,
    Emitter<GameState> emit,
  ) {
    emit(state.copyWith(
      gameMode: event.gameMode,
      phase: const NotStarted(selectedPlayer: Player.x),
    ));

    final mode = event.gameMode;
    if (mode is AIMode && mode.humanPlayer == Player.o) {
      Future.delayed(const Duration(milliseconds: kGameStartDelayMs), () {
        add(const StartAIGameEvent());
      });
    }
  }

  void _onChangeGameMode(
    ChangeGameModeEvent event,
    Emitter<GameState> emit,
  ) {
    emit(GameState(
      xWinCount: 0,
      oWinCount: 0,
      phase: const NotStarted(selectedPlayer: Player.x),
      gameMode: event.gameMode,
    ));

    final mode = event.gameMode;
    if (mode is AIMode && mode.humanPlayer == Player.o) {
      Future.delayed(const Duration(milliseconds: kGameStartDelayMs), () {
        add(const StartAIGameEvent());
      });
    }
  }

  void _onAIPlay(
    AIPlayEvent event,
    Emitter<GameState> emit,
  ) {
    if (state.phase is! Playing) return;

    final playing = state.phase as Playing;
    final board = playing.board;
    final currentPlayer = playing.currentPlayer;
    final aiPlayer = _getAIPlayer();
    final mode = state.gameMode;

    if (currentPlayer != aiPlayer) return;
    if (mode is! AIMode) return;

    final aiMove = AIPlayerService.getMoveIndex(
      board: board,
      difficulty: mode.difficulty,
      aiPlayer: aiPlayer,
    );

    _playMove(aiMove, board, currentPlayer, emit);
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

  void _onShowWinnerScreen(
    ShowWinnerScreenEvent event,
    Emitter<GameState> emit,
  ) {
    if (state.phase is Finished) {
      final finished = state.phase as Finished;
      emit(state.copyWith(
        phase: Finished(
          board: finished.board,
          winner: finished.winner,
          winningLine: finished.winningLine,
          showWinnerScreen: true,
        ),
      ));
    }
  }
}
