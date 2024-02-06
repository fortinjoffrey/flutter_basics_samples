import 'dart:async';
import 'dart:typed_data';
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_state.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part '../../parts/map/presentation/widgets/feed_map.dart';
part '../../parts/list/presentation/widgets/feed_list.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
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
                FeedListDisplayMode() => const _FeedList(),
              };
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<FeedBloc, FeedBlocState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      switch (state.displayMode) {
                        case FeedMapDisplayMode():
                          context.read<FeedMapBloc>().add(const OnWillDisappear());
                        case FeedListDisplayMode():
                          context.read<FeedMapBloc>().add(const OnWillAppearEvent());
                      }
                      context.read<FeedBloc>().add(const ToggleDisplayModeEvent());
                    },
                    child: BlocBuilder<FeedBloc, FeedBlocState>(
                      builder: (context, state) {
                        return Text(state.displayMode == const FeedMapDisplayMode() ? 'List view' : 'Map view');
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
