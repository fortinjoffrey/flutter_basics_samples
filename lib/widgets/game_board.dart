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
import 'package:tic_tac_toe_app/widgets/winning_line.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        return switch (state.phase) {
          NotStarted() => const _BoardView(),
          Playing() => const _BoardView(),
          Finished(:final winner, :final winningLine, :final showWinnerScreen) =>
            showWinnerScreen ? _GameResult(winner: winner) : _BoardView(winningLine: winningLine, winner: winner),
        };
      },
    );
  }
}

class _BoardView extends StatelessWidget {
  final List<int>? winningLine;
  final Player? winner;

  const _BoardView({
    this.winningLine,
    this.winner,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      final board = switch (state.phase) {
        Playing(:final board) => board,
        Finished(:final board) => board,
        NotStarted() => List<Player?>.filled(9, null),
      };

      final isHumanTurn = switch (state.phase) {
        NotStarted(:final selectedPlayer) => switch (state.gameMode) {
            AIMode(:final humanPlayer) => selectedPlayer == humanPlayer,
            TwoPlayersMode() => true,
          },
        Playing(:final currentPlayer) => switch (state.gameMode) {
            AIMode(:final humanPlayer) => currentPlayer == humanPlayer,
            TwoPlayersMode() => true,
          },
        Finished() => false,
      };

      return LayoutBuilder(builder: (context, constraints) {
        final size = constraints.maxWidth < constraints.maxHeight ? constraints.maxWidth : constraints.maxHeight;

        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              CustomPaint(
                painter: _BoardPainter(lineColor: kBoardLineColor, lineWidth: 4),
                child: _BoardGrid(
                  size: size,
                  symbols: board,
                  isHumanTurn: isHumanTurn,
                ),
              ),
              if (winningLine != null)
                WinningLine(
                  winningLine: winningLine!,
                  cellSize: size / 3,
                  color: winner == Player.x ? kPlayerXColor : kPlayerOColor,
                  strokeWidth: 8,
                ),
            ],
          ),
        );
      });
    });
  }
}

class _BoardPainter extends CustomPainter {
  final Color lineColor;
  final double lineWidth;

  _BoardPainter({
    required this.lineColor,
    required this.lineWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round;

    final cellSize = size.width / 3;

    canvas.drawLine(
      Offset(cellSize, 0),
      Offset(cellSize, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(cellSize * 2, 0),
      Offset(cellSize * 2, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(0, cellSize),
      Offset(size.width, cellSize),
      paint,
    );
    canvas.drawLine(
      Offset(0, cellSize * 2),
      Offset(size.width, cellSize * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_BoardPainter oldDelegate) => false;
}

class _BoardGrid extends StatelessWidget {
  final double size;
  final List<Player?> symbols;
  final bool isHumanTurn;

  const _BoardGrid({
    required this.size,
    required this.symbols,
    required this.isHumanTurn,
  });

  double get _cellSize => size / 3;
  double get _symbolSize => _cellSize * 0.6;
  double get _symbolStrokeWidth => _symbolSize * 0.13;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: isHumanTurn
              ? () {
                  context.read<GameBloc>().add(CellTappedEvent(index));
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            child: Center(
              child: _PlayerSymbol(
                player: symbols[index],
                size: _symbolSize,
                strokeWidth: _symbolStrokeWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PlayerSymbol extends StatelessWidget {
  final Player? player;
  final double size;
  final double strokeWidth;

  const _PlayerSymbol({
    required this.player,
    required this.size,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (player == null) return const SizedBox.shrink();

    if (player == Player.x) {
      return AnimatedCross(
        size: size,
        color: kPlayerXColor,
        strokeWidth: strokeWidth,
      );
    } else {
      return AnimatedCircle(
        size: size,
        color: kPlayerOColor,
        strokeWidth: strokeWidth,
      );
    }
  }
}

class _GameResult extends StatelessWidget {
  final Player? winner;

  const _GameResult({
    required this.winner,
  });

  @override
  Widget build(BuildContext context) {
    const double winnerSymbolSize = 120;
    const double winnerSymbolStrokeWidth = 12;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.read<GameBloc>().add(const DismissWinnerScreenEvent());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (winner == Player.x)
            const AnimatedCross(
              size: winnerSymbolSize,
              color: kPlayerXColor,
              strokeWidth: winnerSymbolStrokeWidth,
            )
          else if (winner == Player.o)
            const AnimatedCircle(
              size: winnerSymbolSize,
              color: kPlayerOColor,
              strokeWidth: winnerSymbolStrokeWidth,
            )
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedCross(
                  size: 80,
                  color: kPlayerXColor,
                  strokeWidth: 10,
                ),
                SizedBox(width: 30),
                AnimatedCircle(
                  size: 80,
                  color: kPlayerOColor,
                  strokeWidth: 10,
                ),
              ],
            ),
          const SizedBox(height: 20),
          Text(
            winner != null ? 'Gagné' : 'Match nul !',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.read<GameBloc>().add(const RestartGameEvent());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kCardBackgroundColor,
              foregroundColor: kTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Rejouer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
