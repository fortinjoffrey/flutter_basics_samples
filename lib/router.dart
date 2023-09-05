import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/main.dart';
import 'package:flutter_basics_samples/screens/details_screen.dart';
import 'package:flutter_basics_samples/screens/home_screen.dart';
import 'package:flutter_basics_samples/screens/modal_screen.dart';
import 'package:flutter_basics_samples/screens/person_screen.dart';
import 'package:go_router/go_router.dart';

final modalRoute = GoRoute(
  path: 'modal',
  pageBuilder: (context, state) => const MaterialPage(
    fullscreenDialog: true,
    child: ModalScreen(),
  ),
);

final detailRoute = GoRoute(
  path: 'detail',
  builder: (context, state) => const DetailScreen(),
  routes: [
    modalRoute,
  ],
);

final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          builder: (context, state) => const DetailScreen(),
          routes: [
            GoRoute(
              path: 'modal',
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: ModalScreen(),
              ),
            )
          ],
        ),
        GoRoute(
          path: 'modal',
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: ModalScreen(),
          ),
        ),
        GoRoute(
          name: 'person',
          path: 'person/:id/:name',
          builder: (BuildContext context, GoRouterState state) {
            return PersonScreen(
              id: state.pathParameters['id']!,
              name: state.pathParameters['name']!,
            );
          },
        ),
      ],
    ),
  ],
);
