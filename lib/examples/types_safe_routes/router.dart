import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/types_safe_routes/types_safe_routes.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart'; // name of generated file



// Define how your route tree (path and sub-routes)
@TypedGoRoute<HomeScreenRoute>(
  path: '/home',
  routes: [
    // Add sub-routes
    TypedGoRoute<SongRoute>(
      name: 'song1',
      path: 'song/:id',
    )
  ],
)


@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<LoginScreenRoute>(
  path: '/login',
  routes: [
    // Add sub-routes
    // TypedGoRoute<SongRoute>(
    //   name: 'song2',
    //   path: 'song/:id',
    // )
  ],
)
@immutable
class LoginScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

// final songRoute =@TypedGoRoute<SongRoute>(
//       path: 'song/:id',
//     )

@immutable
class SongRoute extends GoRouteData {
  final int id;
  const SongRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SongScreen(songId: id);
  }
}
