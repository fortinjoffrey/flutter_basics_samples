import 'package:basics_samples/models/music.dart';
import 'package:flutter/material.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget({super.key, required this.music, required this.onTap});

  final Music music;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(music.title), onTap: onTap);
  }
}
