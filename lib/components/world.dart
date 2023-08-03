import 'dart:async';

import 'package:fighting_zombie_with_flame/components/land.dart';
import 'package:fighting_zombie_with_flame/components/player.dart';
import 'package:fighting_zombie_with_flame/zombie_game.dart';
import 'package:flame/components.dart';

import '../assets.dart';

class ZombieWorld extends World with HasGameRef<ZombieGame> {
  ZombieWorld({super.children});

  final List<Land> lands = [];
  late final Player player;

  static Vector2 size = Vector2.all(100);

  @override
  FutureOr<void> onLoad() async {
    final greenLandImage = game.images.fromCache(Assets.assets_images_banner_png);
    lands.add(Land(
      position: Vector2.all(50),
      sprite: Sprite(greenLandImage),
    ));
    add(lands.last);

    final playerImage = game.images.fromCache(Assets.assets_images_coin_png);
    player = Player(position: Vector2.all(20), sprite: Sprite(playerImage));
    add(player);
  }
}
