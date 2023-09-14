import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/router/router.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

void mainTypeSafeStatefulShellRoute() {
  runApp(NestedTabNavigationExampleApp());
}

class NestedTabNavigationExampleApp extends StatelessWidget {
  NestedTabNavigationExampleApp({super.key});

  final _router = GoRouter(
    routes: $appRoutes,
    initialLocation: const HomeRoute().location,
  );
  // final GoRouter _router = GoRouter(
  //   navigatorKey: _rootNavigatorKey,
  //   initialLocation: '/b/details/1/2',
  //   routes: <RouteBase>[
  //     StatefulShellRoute.indexedStack(
  //       builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
  //         return ScaffoldWithNavBar(navigationShell: navigationShell);
  //       },
  //       branches: <StatefulShellBranch>[
  //         StatefulShellBranch(
  //           navigatorKey: _sectionANavigatorKey,
  //           routes: <RouteBase>[
  //             GoRoute(
  //               path: '/a',
  //               builder: (BuildContext context, GoRouterState state) =>
  //                   const RootScreen(label: 'A', detailsPath: '/a/details'),
  //               routes: <RouteBase>[
  //                 GoRoute(
  //                   path: 'details',
  //                   builder: (BuildContext context, GoRouterState state) => DetailsScreen(
  //                     label: 'A',
  //                     model: state.extra as DetailsModel,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         StatefulShellBranch(
  //           routes: <RouteBase>[
  //             GoRoute(
  //               path: '/b',
  //               builder: (BuildContext context, GoRouterState state) {
  //                 return const RootScreen(
  //                   label: 'B',
  //                   detailsPath: '/b/details/1/2',
  //                   secondDetailsPath: '/b/details/2',
  //                 );
  //               },
  //               routes: <RouteBase>[
  //                 GoRoute(
  //                   path: 'details/:param/:id',
  //                   parentNavigatorKey: _rootNavigatorKey,
  //                   builder: (BuildContext context, GoRouterState state) {
  //                     final pathParams = state.pathParameters;

  //                     return DetailsScreen(
  //                       label: 'B',
  //                       param: state.pathParameters['param'],
  //                       model: state.extra as DetailsModel,
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         StatefulShellBranch(
  //           routes: <RouteBase>[
  //             GoRoute(
  //               path: '/c',
  //               builder: (BuildContext context, GoRouterState state) => const RootScreen(
  //                 label: 'C',
  //                 detailsPath: '/c/details',
  //               ),
  //               routes: <RouteBase>[
  //                 GoRoute(
  //                   path: 'details',
  //                   builder: (BuildContext context, GoRouterState state) => DetailsScreen(
  //                     label: 'C',
  //                     extra: state.extra,
  //                     model: state.extra as DetailsModel,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screeen'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // TextButton(
            //   onPressed: () {
            //     GoRouter.of(context).go(detailsPath, extra: DetailsModel('XGS'));
            //   },
            //   child: const Text('View details'),
            // ),
            // const Padding(padding: EdgeInsets.all(4)),
            // if (secondDetailsPath != null)
            //   TextButton(
            //     onPressed: () {
            //       GoRouter.of(context).go(secondDetailsPath!);
            //     },
            //     child: const Text('View more details'),
            //   ),
          ],
        ),
      ),
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Home', icon: Icon(Icons.home)),
          NavigationDestination(label: 'Account', icon: Icon(Icons.account_box)),
        ],
        onDestinationSelected: (int index) => _onTap(context, index),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({
    required this.label,
    required this.detailsPath,
    this.secondDetailsPath,
    super.key,
  });

  final String label;

  final String detailsPath;

  final String? secondDetailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root of section $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label', style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath, extra: DetailsModel('XGS'));
              },
              child: const Text('View details'),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            if (secondDetailsPath != null)
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go(secondDetailsPath!);
                },
                child: const Text('View more details'),
              ),
          ],
        ),
      ),
    );
  }
}

class DetailsModel {
  final String name;

  DetailsModel(this.name);
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    required this.label,
    this.param,
    this.extra,
    this.withScaffold = true,
    super.key,
    required this.model,
  });

  final String label;

  final String? param;

  final Object? extra;

  final bool withScaffold;

  final DetailsModel model;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.withScaffold) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Details Screen - ${widget.label}'),
        ),
        body: _build(context),
      );
    } else {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _build(context),
      );
    }
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('model name ${widget.model.name}', style: Theme.of(context).textTheme.titleLarge),
          Text('Details for ${widget.label} - Counter: $_counter', style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.param != null) Text('Parameter: ${widget.param!}', style: Theme.of(context).textTheme.titleMedium),
          const Padding(padding: EdgeInsets.all(8)),
          if (widget.extra != null) Text('Extra: ${widget.extra!}', style: Theme.of(context).textTheme.titleMedium),
          if (!widget.withScaffold) ...<Widget>[
            const Padding(padding: EdgeInsets.all(16)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text('< Back', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ]
        ],
      ),
    );
  }
}
