import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.views_profile.tr()),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).push(ColorfulRoute());
          },
          child: Text(LocaleKeys.navigation_to_red_view.tr()),
        ),
      ),
    );
  }
}
