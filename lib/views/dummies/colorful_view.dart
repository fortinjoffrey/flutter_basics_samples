import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ColorfulView extends StatelessWidget {
  const ColorfulView({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.views_red.tr()),
      ),
      body: Container(
        color: color ?? Colors.red,
        child: Center(
          child: ElevatedButton(
            child: Text(LocaleKeys.navigation_back.tr()),
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
