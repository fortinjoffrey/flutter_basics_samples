import 'package:basics_samples/components/miniplayer_widget.dart';
import 'package:basics_samples/models/album.dart';
import 'package:basics_samples/music_controller/music_controller_cubit.dart';
import 'package:basics_samples/music_controller/music_controller_state.dart';
import 'package:basics_samples/pages/album_page.dart';
import 'package:basics_samples/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MusicControllerCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) {
          final routeName = settings.name;
          if (routeName == '/') {
            return MaterialPageRoute(
              builder: (_) => HomePage(),
            );
          }
          if (routeName == '/details') {
            final album = settings.arguments as Album;
            return MaterialPageRoute(
              builder: (_) => AlbumPage(album: album),
            );
          }
          throw 1;
        },
        builder: (context, child) {
          return Stack(
            children: [
              if (child != null) child,
              BlocBuilder<MusicControllerCubit, MusicControllerState>(
                builder: (context, state) {
                  final musicData = state.music;

                  if (musicData != null) {
                    return Miniplayer(
                      minHeight: 70,
                      maxHeight: 370,
                      builder: (height, percentage) {
                        return MiniPlayerWidget(
                          music: musicData,
                          onStopPressed: context.read<MusicControllerCubit>().stopMusic,
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
