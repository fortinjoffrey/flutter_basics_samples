import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc.dart';
import 'package:flutter_basics_samples/presentation/admin/screens/admin_screen.dart';
import 'package:flutter_basics_samples/presentation/calendar/screens/calendar_screen.dart';
import 'package:flutter_basics_samples/presentation/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_basics_samples/presentation/employees/screens/employees_screen.dart';
import 'package:flutter_basics_samples/presentation/establishments/screens/establishment_screen.dart';
import 'package:flutter_basics_samples/presentation/main/main_screen.dart';
import 'package:flutter_basics_samples/presentation/navigation/route_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> parentNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteNames.calendar,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.calendar,
              name: RouteNames.calendar,
              builder: (context, state) => const CalendarScreen(),
            ),
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
                    GoRoute(
                      path: RouteNames.adminDashboard,
                      name: RouteNames.adminDashboard,
                      builder: (context, state) => const DashboardScreen(),
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: RouteNames.adminEstablishment,
                      name: RouteNames.adminEstablishment,
                      builder: (context, state) => const EstablishmentScreen(),
                    ),
                  ],
                ),
                StatefulShellBranch(
                  routes: [
                    GoRoute(
                      path: RouteNames.adminEmployees,
                      name: RouteNames.adminEmployees,
                      builder: (context, state) => const EmployeesScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
