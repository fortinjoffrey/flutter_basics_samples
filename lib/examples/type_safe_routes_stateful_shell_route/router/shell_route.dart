part of 'router.dart';

@TypedStatefulShellRoute<HomeStatefulShellRoute>(
  branches: [
    TypedStatefulShellBranch<HomeShellBranch>(
      routes: [
        TypedGoRoute<HomeRoute>(
          path: '/home',
          routes: [
            TypedGoRoute<HomeSearchRoute>(path: 'details', name: 'home-details'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<HomeShellBranch>(
      routes: [
        TypedGoRoute<AccountRoute>(
          path: '/account',
          routes: [
            TypedGoRoute<AccountDetailsRoute>(path: 'details', name: 'account-details'),
          ],
        ),
      ],
    ),
  ],
)
class HomeStatefulShellRoute extends StatefulShellRouteData {
  const HomeStatefulShellRoute();
  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  }
}

class HomeShellBranch extends StatefulShellBranchData {
  const HomeShellBranch();
}

extension HomeShellBranchX on HomeShellBranch {
  GlobalKey<NavigatorState> get navigatorKey => _sectionANavigatorKey;
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

class HomeSearchRoute extends GoRouteData {
  const HomeSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeSearchScreen();
}

class AccountShellBranch extends StatefulShellBranchData {
  const AccountShellBranch();
}

// extension AccountShellBranchX on AccountShellBranch {
//   GlobalKey<NavigatorState> get navigatorKey => _sectionANavigatorKey;
// }

class AccountRoute extends GoRouteData {
  const AccountRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AccountScreen();
}

class AccountDetailsRoute extends GoRouteData {
  const AccountDetailsRoute({required this.id, required this.age});

  final String id;
  final int age;

  @override
  Widget build(BuildContext context, GoRouterState state) => AccountDetailsScreen(id: id, age: age);
}
