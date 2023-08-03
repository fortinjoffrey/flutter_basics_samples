import 'dart:async';

import 'package:fighting_zombie_with_flame/components/world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'assets.dart';

class ZombieGame extends FlameGame with HasKeyboardHandlerComponents {
  ZombieGame() : _world = ZombieWorld() {
    cameraComponent = CameraComponent(world: _world);
    images.prefix = '';
  }

  final ZombieWorld _world;
  late final CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() async {
    cameraComponent.viewfinder.anchor = Anchor.center;
    await images.loadAll([
      Assets.assets_images_banner_png,
      Assets.assets_images_coin_png,
    ]);
    add(_world);
    add(cameraComponent);

    cameraComponent.follow(_world.player);
  }
}
