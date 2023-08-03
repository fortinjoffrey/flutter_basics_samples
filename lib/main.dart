import 'package:fighting_zombie_with_flame/assets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.assets_images_banner_png),
              Image.asset(Assets.assets_images_barrel_png),
              Image.asset(Assets.assets_images_character_human_png),
              Image.asset(Assets.assets_images_character_orc_png),
            ],
          ),
        ),
      ),
    );
  }
}
