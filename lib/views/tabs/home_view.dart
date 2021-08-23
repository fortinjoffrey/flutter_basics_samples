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
          ],
        ),
      ),
    );
  }
}
