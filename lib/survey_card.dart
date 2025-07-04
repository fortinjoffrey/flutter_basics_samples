import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/models/survey.dart';

class SurveyCard extends StatefulWidget {
  const SurveyCard({
    super.key,
    required this.survey,
    required this.backgroundColor,
    required this.onAnswer,
  });

  final Survey survey;
  final Color backgroundColor;
  final void Function(String answer) onAnswer;

  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: math.pi).animate(_flipController);

    if (widget.survey.displayResults) {
      _flipController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _onAnswerTapped(String answer) {
    if (_flipController.isAnimating) return;

    _flipController.forward();

    widget.onAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) {
        final angle = _flipAnimation.value;
        final isShowingFront = angle < math.pi / 2;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(32),
            ),
            child: isShowingFront
                ? _FrontSide(survey: widget.survey, onAnswer: _onAnswerTapped)
                : _BackSide(survey: widget.survey),
          ),
        );
      },
    );
  }
}

class _FrontSide extends StatelessWidget {
  const _FrontSide({required this.survey, required this.onAnswer});

  final Survey survey;
  final void Function(String answer) onAnswer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            survey.question,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          const Text(
            'Que pensez-vous de cette question ?',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AnswerButton(emoji: '😍', label: 'Excellente', value: 'A', onAnswer: onAnswer),
              _AnswerButton(emoji: '👍', label: 'Bonne', value: 'B', onAnswer: onAnswer),
              _AnswerButton(emoji: '😐', label: 'Moyenne', value: 'C', onAnswer: onAnswer),
              _AnswerButton(emoji: '👎', label: 'Mauvaise', value: 'D', onAnswer: onAnswer),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackSide extends StatelessWidget {
  const _BackSide({required this.survey});

  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Merci pour votre réponse !',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              survey.question,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Simulation de résultats
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Text(
                    'Résultats du sondage:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('😍 Excellente'),
                      Text('35%'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('👍 Bonne'),
                      Text('40%'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('😐 Moyenne'),
                      Text('20%'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('👎 Mauvaise'),
                      Text('5%'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.emoji,
    required this.label,
    required this.value,
    required this.onAnswer,
  });

  final String emoji;
  final String label;
  final String value;
  final void Function(String answer) onAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onAnswer(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
