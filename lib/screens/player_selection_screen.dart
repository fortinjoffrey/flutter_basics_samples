import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_bloc.dart';
import 'package:tic_tac_toe_app/bloc/game_event.dart';
import 'package:tic_tac_toe_app/constants/colors.dart';
import 'package:tic_tac_toe_app/models/difficulty.dart';
import 'package:tic_tac_toe_app/models/game_mode.dart';
import 'package:tic_tac_toe_app/models/player.dart';
import 'package:tic_tac_toe_app/screens/game_screen.dart';
import 'package:tic_tac_toe_app/widgets/animated_circle.dart';
import 'package:tic_tac_toe_app/widgets/animated_cross.dart';

class PlayerSelectionScreen extends StatefulWidget {
  final Difficulty difficulty;

  const PlayerSelectionScreen({
    super.key,
    required this.difficulty,
  });

  @override
  State<PlayerSelectionScreen> createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  bool _showIcons = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showIcons = true;
        });
      }
    });
  }

  void _selectPlayer(Player player) {
    context.read<GameBloc>().add(
          SelectGameModeEvent(
            AIMode(
              difficulty: widget.difficulty,
              humanPlayer: player,
            ),
          ),
        );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const GameScreen(),
      ),
    );
  }

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
                  'Choisissez votre symbole',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Vous jouez contre l\'ordinateur',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: kInactiveColor,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                AnimatedOpacity(
                  opacity: _showIcons ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PlayerButton(
                        player: Player.x,
                        color: kPlayerXColor,
                        icon: const AnimatedCross(
                          size: 80,
                          color: kPlayerXColor,
                          strokeWidth: 10,
                        ),
                        onTap: () => _selectPlayer(Player.x),
                      ),
                      const SizedBox(width: 30),
                      _PlayerButton(
                        player: Player.o,
                        color: kPlayerOColor,
                        icon: const AnimatedCircle(
                          size: 80,
                          color: kPlayerOColor,
                          strokeWidth: 10,
                        ),
                        onTap: () => _selectPlayer(Player.o),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: kInactiveColor),
                      const SizedBox(width: 8),
                      Text(
                        'Retour',
                        style: TextStyle(
                          color: kInactiveColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerButton extends StatelessWidget {
  final Player player;
  final Color color;
  final Widget icon;
  final VoidCallback onTap;

  const _PlayerButton({
    required this.player,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: kCardBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: icon,
      ),
    );
  }
}
