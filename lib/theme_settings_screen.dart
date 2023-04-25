import 'package:basics_samples/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ThemeSettingsScreen'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().updateThemeMode(ThemeMode.system);
              },
              child: const Text('System'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().updateThemeMode(ThemeMode.light);
              },
              child: const Text('Light'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeCubit>().updateThemeMode(ThemeMode.dark);
              },
              child: const Text('Dark'),
            ),
          ],
        ));
  }
}
