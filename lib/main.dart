import 'package:flutter/material.dart';

import 'navigation/app_router.gr.dart';
import 'navigation/auth_guard.dart';

void main() {
  runApp(App());
}

final _appRouter = AppRouter(authGuard: AuthGuard());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'autoroute-nested-navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // needed for autoroute navigation
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
