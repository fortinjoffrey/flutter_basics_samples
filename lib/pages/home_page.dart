import 'package:basics_samples/components/album_widget.dart';
import 'package:basics_samples/components/music_widget.dart';
import 'package:basics_samples/data/albums_fixtures.dart';
import 'package:basics_samples/data/music_fixtures.dart';
import 'package:basics_samples/music_controller/music_controller_cubit.dart';
import 'package:basics_samples/music_controller/music_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 120.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AlbumFixtures.albums.length,
                itemBuilder: (context, index) {
                  final album = AlbumFixtures.albums[index];

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: AlbumWiget(
                      color: Colors.primaries[index % Colors.primaries.length],
                      album: album,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/details',
                          arguments: album,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          BlocBuilder<MusicControllerCubit, MusicControllerState>(
            builder: (context, state) {
              final hasMusicPlaying = state.music != null;
              return SliverPadding(
                padding: EdgeInsets.only(bottom: hasMusicPlaying ? 72 : 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final music = MusicFixtures.mostPopular[index];
                      return MusicWidget(
                        music: music,
                        onTap: () {
                          context.read<MusicControllerCubit>().startMusic(music);
                        },
                      );
                    },
                    childCount: MusicFixtures.mostPopular.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
