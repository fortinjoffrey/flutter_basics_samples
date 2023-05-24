import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

abstract class UrlUtils {
  static Future<bool> tryLaunchUrlWithUrlLauncher(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: mode,
        );
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  
}
