import 'package:flutter/material.dart';

import 'overflowed_avatars.dart';

class ProblemToSolve extends StatelessWidget {
  const ProblemToSolve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('15:00'),
              ),
              Container(
                width: 1,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                      OverflowedAvatars(),
                    ],
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
