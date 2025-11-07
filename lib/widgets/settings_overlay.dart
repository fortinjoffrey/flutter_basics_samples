import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/constants/colors.dart';
import 'package:tic_tac_toe_app/models/difficulty.dart';
import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/player.dart';
import 'package:tic_tac_toe_app/widgets/animated_circle.dart';
import 'package:tic_tac_toe_app/widgets/animated_cross.dart';

class SettingsOverlay extends StatefulWidget {
  final GameMode currentGameMode;
  final Function(GameMode) onGameModeSelected;
  final VoidCallback onResetScores;

  const SettingsOverlay({
    super.key,
    required this.currentGameMode,
    required this.onGameModeSelected,
    required this.onResetScores,
  });

  static void show(
    BuildContext context, {
    required GameMode currentGameMode,
    required Function(GameMode) onGameModeSelected,
    required VoidCallback onResetScores,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (context) => SettingsOverlay(
        currentGameMode: currentGameMode,
        onGameModeSelected: onGameModeSelected,
        onResetScores: onResetScores,
      ),
    );
  }

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  Player? _selectedPlayer;

  @override
  void initState() {
    super.initState();
    final mode = widget.currentGameMode;
    if (mode is AIMode) {
      _selectedPlayer = mode.humanPlayer;
    }
  }

  bool _isModeSelected(Difficulty? difficulty) {
    final currentMode = widget.currentGameMode;
    if (difficulty == null) {
      return currentMode is TwoPlayersMode;
    }
    return currentMode is AIMode && currentMode.difficulty == difficulty;
  }

  void _selectDifficulty(Difficulty difficulty) {
    setState(() {
      _selectedPlayer ??= Player.x;
    });
    widget.onGameModeSelected(AIMode(
      difficulty: difficulty,
      humanPlayer: _selectedPlayer!,
    ));
    Navigator.of(context).pop();
  }

  void _selectTwoPlayers() {
    widget.onGameModeSelected(const TwoPlayersMode());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isAIMode = widget.currentGameMode is AIMode;

    return Dialog(
      backgroundColor: kCardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paramètres',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: kTextColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Mode de jeu',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: kInactiveColor,
                  ),
            ),
            const SizedBox(height: 16),
            _GameModeOption(
              icon: Icons.sentiment_satisfied,
              label: 'Facile',
              color: kEasyColor,
              isSelected: _isModeSelected(Difficulty.easy),
              onTap: () => _selectDifficulty(Difficulty.easy),
            ),
            const SizedBox(height: 12),
            _GameModeOption(
              icon: Icons.sentiment_neutral,
              label: 'Moyen',
              color: kMediumColor,
              isSelected: _isModeSelected(Difficulty.medium),
              onTap: () => _selectDifficulty(Difficulty.medium),
            ),
            const SizedBox(height: 12),
            _GameModeOption(
              icon: Icons.sentiment_very_dissatisfied,
              label: 'Impossible',
              color: kHardColor,
              isSelected: _isModeSelected(Difficulty.impossible),
              onTap: () => _selectDifficulty(Difficulty.impossible),
            ),
            const SizedBox(height: 12),
            _GameModeOption(
              icon: Icons.people,
              label: 'Jouer contre un ami',
              color: kPlayerOColor,
              isSelected: _isModeSelected(null),
              onTap: _selectTwoPlayers,
            ),
            if (isAIMode) ...[
              const SizedBox(height: 32),
              const Divider(color: kDividerColor),
              const SizedBox(height: 16),
              Text(
                'Votre symbole',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: kInactiveColor,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _PlayerSelectionButton(
                      player: Player.x,
                      isSelected: _selectedPlayer == Player.x,
                      onTap: () {
                        final mode = widget.currentGameMode;
                        if (mode is AIMode) {
                          widget.onGameModeSelected(AIMode(
                            difficulty: mode.difficulty,
                            humanPlayer: Player.x,
                          ));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _PlayerSelectionButton(
                      player: Player.o,
                      isSelected: _selectedPlayer == Player.o,
                      onTap: () {
                        final mode = widget.currentGameMode;
                        if (mode is AIMode) {
                          widget.onGameModeSelected(AIMode(
                            difficulty: mode.difficulty,
                            humanPlayer: Player.o,
                          ));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),
            const Divider(color: kDividerColor),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onResetScores();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBackgroundColor,
                  foregroundColor: kTextColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Réinitialiser les scores',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _GameModeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _GameModeOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : kBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: kTextColor,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 24),
          ],
        ),
      ),
    );
  }
}

class _PlayerSelectionButton extends StatelessWidget {
  final Player player;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlayerSelectionButton({
    required this.player,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = player == Player.x ? kPlayerXColor : kPlayerOColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : kBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: player == Player.x
              ? const AnimatedCross(
                  size: 40,
                  color: kPlayerXColor,
                  strokeWidth: 5,
                )
              : const AnimatedCircle(
                  size: 40,
                  color: kPlayerOColor,
                  strokeWidth: 5,
                ),
        ),
      ),
    );
  }
}
