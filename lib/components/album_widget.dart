import 'package:basics_samples/models/album.dart';
import 'package:flutter/material.dart';

class AlbumWiget extends StatelessWidget {
  const AlbumWiget({
    super.key,
    required this.album,
    required this.onPressed,
    required this.color,
  });

  final Album album;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Card(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(album.title),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
