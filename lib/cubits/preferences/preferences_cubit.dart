import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_state.dart';

const showOnboardingKey = 'showOnboarding';

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(this.sharedPreferences)
      : super(
          PreferencesState(
            showOnboarding: sharedPreferences.getBool(showOnboardingKey) ?? true,
          ),
        );

  final SharedPreferences sharedPreferences;

  Future<void> onboardingDone() async {
    sharedPreferences.setBool(showOnboardingKey, false);
    emit(PreferencesState(showOnboarding: false));
  }
}
