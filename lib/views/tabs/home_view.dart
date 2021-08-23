import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.views_home.tr()),
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
              child: Text(LocaleKeys.common_auth_sign_out.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(const PlaceholderRoute());
              },
              child: Text(LocaleKeys.navigation_to_placeholder_in_router.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).root.push(const PlaceholderRoute());
              },
              child: Text(LocaleKeys.navigation_to_placeholder.tr()),
            ),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(const Locale('en'));
                },
                child: const Text('English')),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(const Locale('fr'));
                },
                child: const Text('Français')),
          ],
        ),
      ),
    );
  }
}
