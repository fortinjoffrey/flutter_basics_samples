import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class EnvUtil {
  static final String googleMapsApiKey = _getGoogleMapsApiKey();

  static String _getGoogleMapsApiKey() {
    if (kIsWeb) {
      return const String.fromEnvironment('WEB_GOOGLE_MAPS_API_KEY');
    } else if (Platform.isIOS) {
      return const String.fromEnvironment('IOS_GOOGLE_MAPS_API_KEY');
    } else if (Platform.isAndroid) {
      return const String.fromEnvironment('ANDROID_GOOGLE_MAPS_API_KEY');
    } else {
      throw Exception('Unsupported platform detected.');
    }
  }
}
