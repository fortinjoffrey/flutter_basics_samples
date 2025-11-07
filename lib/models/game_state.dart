import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/game_phase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    required int xWinCount,
    required int oWinCount,
    required GamePhase phase,
    required GameMode gameMode,
  }) = _GameState;
}
