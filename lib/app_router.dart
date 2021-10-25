import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(
      path: 'home',
      page: HomeView,
      fullscreenDialog: true,
      initial: true,
    ),
    AutoRoute<void>(
      path: 'page1',
      page: Page1View,
      fullscreenDialog: true,
    ),
    AutoRoute<void>(
      path: 'page2',
      page: Page2View,
    ),
    CupertinoRoute<void>(
      path: 'page3',
      page: Page3View,
    ),
  ],
)
class $AppRouter {}
