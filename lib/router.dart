import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/screens/details_screen.dart';
import 'package:flutter_basics_samples/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

import 'sign_up_dialog.dart';

part 'router.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<DetailsRoute>(
      path: 'details/:itemId',
    )
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class DetailsRoute extends GoRouteData {
  const DetailsRoute({
    required this.itemId,
    this.itemName,
    this.shoudShowDialog,
    this.isFavorite,
    this.initialSignUpStep,
  });

  final String itemId;
  final String? itemName;
  final bool? isFavorite;
  final bool? shoudShowDialog;
  final SignUpSteps? initialSignUpStep;

  @override
  Widget build(BuildContext context, GoRouterState state) => DetailsScreen(
        itemId: itemId,
        itemName: itemName,
        isFavorite: isFavorite,
        shoudShowDialog: shoudShowDialog,
        initialSignUpStep: initialSignUpStep,
      );
}
