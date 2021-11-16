import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService(this._sharedPreferences);

  static const _storekeyShowOnboarding = 'showOnboarding';
  final SharedPreferences _sharedPreferences;

  bool get showOnboarding => _sharedPreferences.getBool(_storekeyShowOnboarding) ?? true;

  set showOnboarding(bool show) {
    _sharedPreferences.setBool(_storekeyShowOnboarding, show);
  }
}
