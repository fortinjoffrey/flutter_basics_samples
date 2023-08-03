# Package assets_gen

[![Pub Version](https://img.shields.io/pub/v/assets_gen)](https://pub.dev/packages/assets_gen)

The `assets_gen` package helps you to generate a .dart file that contains all assets according to `pubspec.yaml`.

| Way to reference asset path | Sample Code                                  |          |
| ---------------------------- | -------------------------------------------- | -------- |
| Use string path directly     | `Image.asset('assets/images/foo.png');`      | ❌ Unsafe |
| Use `assets_gen`             | `Image.asset(Assets.assets_images_foo_png);` | ✅ Good   |