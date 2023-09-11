// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/types_safe_routes/router.dart';
import 'package:go_router/go_router.dart';

void mainTypesSafeRoutes() => runApp(const App());

final _router = GoRouter(
  routes: $appRoutes,
  initialLocation: HomeScreenRoute().location,
);

/// The main app.
class App extends StatelessWidget {
  /// Creates an [App].
  const App({super.key});

  /// The title of the app.
  static const String title = 'GoRouter Example: Types Safe Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: title,
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final result = await const SongRoute(id: 12).push(context);
                print(result);
                // const SongRoute(id: 12).go(context);
              },
              child: const Text('push /home/song/12'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                const SongRoute(id: 12).go(context);
              },
              child: const Text('go /home/song/12'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            const SongRoute(id: 12).go(context);
            // print(result);
          },
          child: const Text('go /login/song/12'),
        ),
      ),
    );
  }
}

class SongScreen extends StatelessWidget {
  const SongScreen({super.key, required this.songId});

  final int songId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Song Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Song $songId'),
            TextButton(
                onPressed: () {
                  context.pop(true);
                },
                child: const Text('pop true')),
          ],
        ),
      ),
    );
  }
}
