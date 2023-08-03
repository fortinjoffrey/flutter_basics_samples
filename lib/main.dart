import 'package:fighting_zombie_with_flame/zombie_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final game = ZombieGame();
  runApp(MainApp(
    game: game,
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.game});
  final ZombieGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameWidget(game: ZombieGame()),
    );
  }
}
