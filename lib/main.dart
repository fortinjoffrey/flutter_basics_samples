import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/env_util.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/screens/feed_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final googleMapsApiKey = EnvUtil.googleMapsApiKey;

  // ignore: avoid_print
  print(googleMapsApiKey);
  await DepencyInjector.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<FeedBloc>(
            create: (context) => FeedBloc(),
          ),
          BlocProvider<FeedMapBloc>(
            create: (context) => FeedMapBloc(),
          ),
        ],
        child: const FeedScreen(),
      ),
    );
  }
}
