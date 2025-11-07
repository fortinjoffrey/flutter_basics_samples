import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_event.dart';
import 'package:tic_tac_toe_app/constants/colors.dart';
import 'package:tic_tac_toe_app/models/difficulty.dart';
import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/screens/player_selection_screen.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';

class GameModeSelectionScreen extends StatelessWidget {
  const GameModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Morpion',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Choisissez un mode de jeu',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: kInactiveColor,
                      ),
                ),
                const SizedBox(height: 60),
                _GameModeButton(
                  label: 'Facile',
                  icon: Icons.sentiment_satisfied,
                  color: kEasyColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PlayerSelectionScreen(
                          difficulty: Difficulty.easy,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _GameModeButton(
                  label: 'Moyen',
                  icon: Icons.sentiment_neutral,
                  color: kMediumColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PlayerSelectionScreen(
                          difficulty: Difficulty.medium,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _GameModeButton(
                  label: 'Impossible',
                  icon: Icons.sentiment_very_dissatisfied,
                  color: kHardColor,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PlayerSelectionScreen(
                          difficulty: Difficulty.impossible,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _GameModeButton(
                  label: 'Jouer contre un ami',
                  icon: Icons.people,
                  color: kPlayerOColor,
                  onTap: () {
                    context.read<GameBloc>().add(
                          const SelectGameModeEvent(TwoPlayersMode()),
                        );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const GameScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GameModeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GameModeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kCardBackgroundColor,
        foregroundColor: kTextColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color, width: 2),
        ),
        elevation: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
