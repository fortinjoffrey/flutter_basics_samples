import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_state.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part '../../parts/map/presentation/widgets/feed_map.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    print('FeedScreen build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedScreen'),
      ),
      body: Stack(
        children: [
          BlocBuilder<FeedBloc, FeedBlocState>(
            builder: (context, state) {
              return switch (state.displayMode) {
                FeedMapDisplayMode() => const _FeedMap(),
                FeedListDisplayMode() => Container(color: Colors.blue),
              };
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  context.read<FeedBloc>().add(const ToggleDisplayModeEvent());
                },
                child: BlocBuilder<FeedBloc, FeedBlocState>(
                  builder: (context, state) {
                    return Text(state.displayMode == const FeedMapDisplayMode() ? 'List view' : 'Map view');
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
