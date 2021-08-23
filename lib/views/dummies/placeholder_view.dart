import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PlaceholderView extends StatelessWidget {
  const PlaceholderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.views_placeholder.tr()),
      ),
      body: Placeholder(),
    );
  }
}
