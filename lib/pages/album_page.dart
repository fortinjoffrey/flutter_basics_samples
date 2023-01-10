import 'package:basics_samples/components/music_widget.dart';
import 'package:basics_samples/models/album.dart';
import 'package:basics_samples/music_controller/music_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final music = album.musics[index];
                return MusicWidget(
                  music: music,
                  onTap: () {
                    context.read<MusicControllerCubit>().startMusic(music);
                  },
                );
              },
              childCount: album.musics.length,
            ),
          ),
        ],
      ),
    );
  }
}
