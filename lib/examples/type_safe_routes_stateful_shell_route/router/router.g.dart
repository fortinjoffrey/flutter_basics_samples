// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeStatefulShellRoute,
    ];

RouteBase get $homeStatefulShellRoute => StatefulShellRouteData.$route(
      factory: $HomeStatefulShellRouteExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          
          routes: [
            GoRouteData.$route(
              path: '/home',
              factory: $HomeRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  name: 'home-details',
                  factory: $HomeSearchRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/account',
              factory: $AccountRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'details',
                  name: 'account-details',
                  factory: $AccountDetailsRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $HomeStatefulShellRouteExtension on HomeStatefulShellRoute {
  static HomeStatefulShellRoute _fromState(GoRouterState state) =>
      const HomeStatefulShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HomeSearchRouteExtension on HomeSearchRoute {
  static HomeSearchRoute _fromState(GoRouterState state) =>
      const HomeSearchRoute();

  String get location => GoRouteData.$location(
        '/home/details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRouteExtension on AccountRoute {
  static AccountRoute _fromState(GoRouterState state) => const AccountRoute();

  String get location => GoRouteData.$location(
        '/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountDetailsRouteExtension on AccountDetailsRoute {
  static AccountDetailsRoute _fromState(GoRouterState state) =>
      AccountDetailsRoute(
        id: state.uri.queryParameters['id']!,
        age: int.parse(state.uri.queryParameters['age']!),
      );

  String get location => GoRouteData.$location(
        '/account/details',
        queryParams: {
          'id': id,
          'age': age.toString(),
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
