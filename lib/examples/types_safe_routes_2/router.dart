import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/types_safe_routes_2/models.dart';
import 'package:flutter_basics_samples/examples/types_safe_routes_2/types_safe_routes_2.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart'; // name of generated file

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<FamilyRoute>(
      path: 'family/:fid',
      routes: <TypedGoRoute<GoRouteData>>[
        TypedGoRoute<PersonRoute>(
          path: 'person/:pid',
          routes: <TypedGoRoute<GoRouteData>>[
            TypedGoRoute<PersonDetailsRoute>(path: 'details/:details'),
          ],
        ),
      ],
    ),
    TypedGoRoute<FamilyCountRoute>(path: 'family-count/:count', name: 'family-count'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<LoginRoute>(path: '/login', routes: [
  // TypedGoRoute<FamilyCountRoute>(path: 'family-count/:count', name: 'login-family-count'),
])
class LoginRoute extends GoRouteData {
  const LoginRoute({this.fromPage});

  final String? fromPage;

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginScreen(from: fromPage);
}

class FamilyRoute extends GoRouteData {
  const FamilyRoute(this.fid);

  final String fid;

  @override
  Widget build(BuildContext context, GoRouterState state) => FamilyScreen(family: familyById(fid));
}

class PersonRoute extends GoRouteData {
  const PersonRoute(this.fid, this.pid);

  final String fid;
  final int pid;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final Family family = familyById(fid);
    final Person person = family.person(pid);
    return PersonScreen(family: family, person: person);
  }
}

class PersonDetailsRoute extends GoRouteData {
  const PersonDetailsRoute(this.fid, this.pid, this.details, {this.$extra});

  final String fid;
  final int pid;
  final PersonDetails details;
  final int? $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final Family family = familyById(fid);
    final Person person = family.person(pid);

    return MaterialPage<Object>(
      fullscreenDialog: true,
      key: state.pageKey,
      child: PersonDetailsPage(
        family: family,
        person: person,
        detailsKey: details,
        extra: $extra,
      ),
    );
  }
}

class FamilyCountRoute extends GoRouteData {
  const FamilyCountRoute(this.count);

  final int count;

  @override
  Widget build(BuildContext context, GoRouterState state) => FamilyCountScreen(
        count: count,
      );
}
