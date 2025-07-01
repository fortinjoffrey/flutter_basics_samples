import 'package:flutter/material.dart';

class SurveyCard extends StatelessWidget {
  const SurveyCard({super.key, required this.question, required this.backgroundColor});

  final String question;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(child: Text(question)),
    );
  }
}
