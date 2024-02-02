import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../../parts/map/presentation/widgets/feed_map.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<FeedBloc>().add(const InitEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        context.read<FeedBloc>().add(const FeedAppResumedEvent());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedScreen'),
      ),
      body: BlocBuilder<FeedBloc, FeedBlocState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocBuilder<FeedBloc, FeedBlocState>(
                builder: (context, state) {
                  return switch (state.displayMode) {
                    FeedMapDisplayMode() => BlocProvider(
                        create: (_) => FeedMapBloc(),
                        child: const _FeedMap(),
                      ),
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
          );
        },
      ),
    );
  }
}
