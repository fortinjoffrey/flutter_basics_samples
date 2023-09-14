import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/screens/account_details.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/screens/account_screen.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/screens/home_screen.dart';
import 'package:flutter_basics_samples/examples/type_safe_routes_stateful_shell_route/screens/home_search.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';
part 'shell_route.dart';

final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

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
