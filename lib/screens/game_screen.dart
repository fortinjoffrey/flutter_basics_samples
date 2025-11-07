import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_event.dart';
import 'package:tic_tac_toe_app/constants/colors.dart';
import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/game_phase.dart';
import 'package:tic_tac_toe_app/models/game_state.dart';
import 'package:tic_tac_toe_app/models/player.dart';
import 'package:tic_tac_toe_app/widgets/animated_circle.dart';
import 'package:tic_tac_toe_app/widgets/animated_cross.dart';
import 'package:tic_tac_toe_app/widgets/game_board.dart';
import 'package:tic_tac_toe_app/widgets/settings_overlay.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const _ScoreButtons(),
                        const SizedBox(height: 30),
                        const StatusText(),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Center(
                            child: GameBoard(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.settings, color: kTextColor, size: 28),
                    onPressed: () => SettingsOverlay.show(
                      context,
                      currentGameMode: state.gameMode,
                      onGameModeSelected: (mode) {
                        context.read<GameBloc>().add(ChangeGameModeEvent(mode));
                      },
                      onResetScores: () {
                        context.read<GameBloc>().add(const ResetScoresEvent());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ScoreButtons extends StatelessWidget {
  const _ScoreButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        const playerLabel = 'Joueur';
        const computerLabel = 'Ordinateur';

        final xWinCount = state.xWinCount;
        final oWinCount = state.oWinCount;
        final currentPlayer = switch (state.phase) {
          NotStarted(:final selectedPlayer) => selectedPlayer,
          Playing(:final currentPlayer) => currentPlayer,
          Finished() => Player.x,
        };
        final isNotStarted = state.phase is NotStarted;
        final isTwoPlayerMode = state.gameMode is TwoPlayersMode;
        final canSelectStartingPlayer = isNotStarted && isTwoPlayerMode;

        final gameMode = state.gameMode;
        String? xLabel;
        String? oLabel;

        if (gameMode is AIMode) {
          xLabel = gameMode.humanPlayer == Player.x ? playerLabel : computerLabel;
          oLabel = gameMode.humanPlayer == Player.o ? playerLabel : computerLabel;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SelectablePlayerButton(
              player: Player.x,
              wins: xWinCount,
              isActive: currentPlayer == Player.x,
              label: xLabel,
              canSelect: canSelectStartingPlayer,
              icon: const AnimatedCross(
                size: 30,
                color: kPlayerXColor,
                strokeWidth: 4,
              ),
            ),
            const SizedBox(width: 40),
            _SelectablePlayerButton(
              player: Player.o,
              wins: oWinCount,
              isActive: currentPlayer == Player.o,
              label: oLabel,
              canSelect: canSelectStartingPlayer,
              icon: const AnimatedCircle(
                size: 30,
                color: kPlayerOColor,
                strokeWidth: 4,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PlayerButton extends StatelessWidget {
  final Player player;
  final int wins;
  final bool isActive;
  final Widget icon;
  final String? label;

  const PlayerButton({
    super.key,
    required this.player,
    required this.wins,
    required this.isActive,
    required this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kInactiveColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: kCardBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? kTextColor : Colors.transparent,
              width: 3,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
                      child: icon,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      wins == 0 ? '-' : wins.toString(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kTextColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SelectablePlayerButton extends StatelessWidget {
  final Player player;
  final int wins;
  final bool isActive;
  final String? label;
  final Widget icon;
  final bool canSelect;

  const _SelectablePlayerButton({
    required this.player,
    required this.wins,
    required this.isActive,
    required this.label,
    required this.icon,
    required this.canSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (canSelect) {
          context.read<GameBloc>().add(SelectStartingPlayerEvent(player));
        }
      },
      child: PlayerButton(
        player: player,
        wins: wins,
        isActive: isActive,
        label: label,
        icon: icon,
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  const StatusText({super.key});

  String _getPlayerLabel(Player player, GameMode gameMode) {
    switch (gameMode) {
      case AIMode():
        return gameMode.humanPlayer == player ? 'vous' : 'l\'ordinateur';
      case TwoPlayersMode():
        return player == Player.x ? 'X' : 'O';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final text = switch (state.phase) {
          NotStarted(:final selectedPlayer) => switch (state.gameMode) {
              AIMode(:final humanPlayer) => humanPlayer == selectedPlayer
                  ? 'Démarrez le jeu'
                  : "C'est à ${_getPlayerLabel(selectedPlayer, state.gameMode)} de jouer",
              TwoPlayersMode() => 'Démarrez le jeu ou sélectionnez un joueur',
            },
          Playing(:final currentPlayer) => "C'est à ${_getPlayerLabel(currentPlayer, state.gameMode)} de jouer",
          Finished() => 'Partie terminée',
        };

        return Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: kTextColor,
              ),
        );
      },
    );
  }
}
