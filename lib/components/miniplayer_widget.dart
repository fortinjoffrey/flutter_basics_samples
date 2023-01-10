import 'package:basics_samples/models/music.dart';
import 'package:flutter/material.dart';

class MiniPlayerWidget extends StatelessWidget {
  const MiniPlayerWidget({
    super.key,
    required this.music,
    required this.onStopPressed,
  });

  final Music music;
  final VoidCallback onStopPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(child: Text(music.title)),
              IconButton(
                onPressed: onStopPressed,
                icon: Icon(
                  Icons.stop_circle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
