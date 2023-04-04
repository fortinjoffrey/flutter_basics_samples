import 'package:version/version.dart';

enum UpdateInfoStatus {
  unknown,
  latestVersion,
  updateNonMandatory,
  updateMandatory,
}

class VersionsInfoProvider {
  final Version currentVersion;
  final Version latestAvailableVersion;
  final Version lastVersionWithBreakingChanges;

  const VersionsInfoProvider({
    required this.currentVersion,
    required this.latestAvailableVersion,
    required this.lastVersionWithBreakingChanges,
  });

  VersionsInfoProvider.parse({
    required String currentVersionStr,
    required String latestAvailableVersionStr,
    required String lastVersionWithBreakingChangesStr,
  })  : currentVersion = Version.parse(currentVersionStr),
        latestAvailableVersion = Version.parse(latestAvailableVersionStr),
        lastVersionWithBreakingChanges = Version.parse(lastVersionWithBreakingChangesStr);

  bool get latestVersion => currentVersion == latestAvailableVersion;
  bool get nonMandatoryUpdate => currentVersion < latestAvailableVersion;
  bool get mandatoryUpdate => currentVersion < lastVersionWithBreakingChanges;

  bool get updateAvailable => nonMandatoryUpdate || mandatoryUpdate;

  String get latestAvailableVersionNumber =>latestAvailableVersion.toString();

  UpdateInfoStatus get updateInfoStatus {
    if (mandatoryUpdate) return UpdateInfoStatus.updateMandatory;
    if (nonMandatoryUpdate) return UpdateInfoStatus.updateNonMandatory;
    if (latestVersion) return UpdateInfoStatus.latestVersion;
    return UpdateInfoStatus.unknown;
  }

  @override
  String toString() =>
      'VersionsProvider(currentVersion: $currentVersion, latestAvailableVersion: $latestAvailableVersion, lastVersionWithBreakingChanges: $lastVersionWithBreakingChanges)';
}