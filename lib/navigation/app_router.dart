import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/views/dummies/colorful_view.dart';
import 'package:basics_samples/views/login_view.dart';
import 'package:basics_samples/views/main_view.dart';
import 'package:basics_samples/views/dummies/placeholder_view.dart';
import 'package:basics_samples/views/tabs/home_view.dart';
import 'package:basics_samples/views/tabs/profile_view.dart';

import 'auth_guard.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(
      path: '/',
      guards: [AuthGuard],
      page: MainView,
      initial: true,
      children: [
        AutoRoute<void>(
          path: 'home',
          page: EmptyRouterPage,
          name: 'HomeTab',
          children: [
            AutoRoute<void>(
              path: '',
              page: HomeView,
            ),
            AutoRoute<void>(
              path: 'placeholder',
              page: PlaceholderView,
            ),
          ],
        ),
        AutoRoute<void>(
          path: 'profile',
          page: EmptyRouterPage,
          name: 'ProfileTab',
          children: [
            AutoRoute<void>(
              path: '',
              page: ProfileView,
            ),
            AutoRoute<void>(
              path: 'colorful',
              page: ColorfulView,
            ),
          ],
        ),
      ],
    ),
    AutoRoute<void>(
      path: 'login',
      page: LoginView,
      fullscreenDialog: true,
    ),
    AutoRoute<void>(
      path: 'placeholder',
      page: PlaceholderView,
    ),
  ],
)
class $AppRouter {}
