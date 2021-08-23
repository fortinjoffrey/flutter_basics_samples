import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_router.gr.dart';

/// This [AuthGuard] makes sure that a user is signed in before continuing
/// navigation. If not, the [LoginRoute] should be pushed.
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isUserLoggedIn = sharedPreferences.get('loggedIn') as bool?;

    if (isUserLoggedIn == null || isUserLoggedIn == false) {
      router.push(
        LoginRoute(
          onLogin: () {
            router.removeLast();
            resolver.next();
          },
        ),
      );
    } else {
      resolver.next();
    }
  }
}
