import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc_event.dart';
import 'package:flutter_basics_samples/presentation/tabs/bloc/tab_bloc.dart';
import 'package:flutter_basics_samples/presentation/tabs/bloc/tab_bloc_event.dart';
import 'package:flutter_basics_samples/screens/admin_screen.dart';
import 'package:flutter_basics_samples/screens/calendar_screen.dart';
import 'package:flutter_basics_samples/screens/dashboard_screen.dart';
import 'package:flutter_basics_samples/screens/employees_screen.dart';
import 'package:flutter_basics_samples/screens/establishment_screen.dart';
import 'package:flutter_basics_samples/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();
final routeObserver = RouteObserver<ModalRoute<void>>();

final router = GoRouter(
  initialLocation: '/calendar',
  observers: [routeObserver],
  redirect: (context, state) {
    final path = state.fullPath;
    print('path: $path');
    if (path?.startsWith('/admin') ?? false) {
      context.read<TabBloc>().add(TabChangedEvent(tab: Tabs.admin));
    } else if (path?.startsWith('/calendar') ?? false) {
      context.read<TabBloc>().add(TabChangedEvent(tab: Tabs.calendar));
    }

   
    return null; // Ne pas rediriger, juste synchroniser le tab
  },
  routes: [
    StatefulShellRoute.indexedStack(
      // parentNavigatorKey: AppRouter.parentNavigatorKey,
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/calendar', builder: (context, state) => const CalendarScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) {
                return BlocProvider(
                  create: (context) => AdminBloc(),
                  child: AdminScreen(navigationShell: navigationShell),
                );
              },
              branches: [
                StatefulShellBranch(
                  routes: [
                    GoRoute(path: '/admin/dashboard', builder: (context, state) => const DashboardScreen()),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(path: '/admin/establishment', builder: (context, state) => const EstablishmentScreen()),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(path: '/admin/employees', builder: (context, state) => const EmployeesScreen()),
                  ],
                ),
              ],
            ),
            // GoRoute(path: '/admin', builder: (context, state) => const AdminScreen()),
          ],
        ),
      ],
    ),
  ],
);
