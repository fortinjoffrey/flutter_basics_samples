import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final sharedPreferences = await SharedPreferences.getInstance();

                sharedPreferences.setBool('loggedIn', false);

                AutoRouter.of(context).root.replace(const MainRoute());
              },
              child: Text('Sign out'),
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const PlaceholderRoute());
              },
              child: Text('Navigate to placeholder view in router'),
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).root.push(const PlaceholderRoute());
              },
              child: Text('Navigate to placeholder view in root router'),
            ),
            ElevatedButton(
              onPressed: () {
                AutoTabsRouter.of(context).setActiveIndex(1);
              },
              child: Text('Go to second tab'),
            ),
            ElevatedButton(
              onPressed: () async {
                AutoTabsRouter.of(context).setActiveIndex(1);

                // This delay is absolutely important for two reasons:
                // 1. in autoroute 2.3.0, on first launch StackRouters are lazy loaded
                //    meaning that trying to get the Profile stack router will result in null
                //    in the first launch. Once it is init then the router will never be null.
                //    setActiveIndex will trigger the tab router init. Since setActiveIndex is sync
                //    we have to wait a little for the init to be done
                // 2. This might be convenient for the user since he sees what the app is actually doing
                //    It navigates itself and the user is aware of what's going on
                // NB: 500ms is totally arbitrary
                await Future<void>.delayed(const Duration(milliseconds: 500));
                final router = AutoTabsRouter.of(context).innerRouterOf<StackRouter>(ProfileTab.name);

                if (router != null) {
                  router.popUntilRoot();
                  router.push(ColorfulRoute());
                }
              },
              child: Text('Go to profile and push red view'),
            ),
          ],
        ),
      ),
    );
  }
}
