import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final ThemeMode mode;
  final Brightness systemBrightness;

  const ThemeState(this.mode, this.systemBrightness);
}

class ThemeCubit extends Cubit<ThemeState> {
  final Brightness systemBrightness;
  // final SharedPreferences sharedPreferences;

  ThemeCubit(this.systemBrightness) : super(ThemeState(ThemeMode.light, systemBrightness));
  // ThemeCubit(this.sharedPreferences) : super(ThemeState(ThemeMode.light));

  void updateThemeMode(ThemeMode mode) {
    emit(ThemeState(mode, state.systemBrightness));
  }

  void updateBrightness(Brightness brightness) {
    emit(ThemeState(state.mode, brightness));
  }
}
