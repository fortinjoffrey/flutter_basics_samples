import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class FirebaseRemoteConfigKeys {
  static const appbarBackgroundColorKey = 'appbar_background_color';
  static const latestVersionNumber = 'latest_version_number';
  static const lastVersionWithBreakingChangesNumber = 'last_version_with_breaking_changes_number';
}

class FirebaseRemoteConfigManager {
  Future<void> setupFirebaseRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await remoteConfig.setDefaults({
      FirebaseRemoteConfigKeys.appbarBackgroundColorKey: '#FF000000',
      FirebaseRemoteConfigKeys.latestVersionNumber: '#FF000000',
      FirebaseRemoteConfigKeys.lastVersionWithBreakingChangesNumber: '#FF000000',
    });

    await remoteConfig.fetchAndActivate();
  }

  String get latestVersionNumber {
    return FirebaseRemoteConfig.instance.getString(FirebaseRemoteConfigKeys.latestVersionNumber);
  }

  String get lastVersionWithBreakingChangesNumber {
    return FirebaseRemoteConfig.instance.getString(FirebaseRemoteConfigKeys.lastVersionWithBreakingChangesNumber);
  }
}
