import 'package:basics_samples/theme_cubit.dart';
import 'package:basics_samples/theme_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black54,
  primaryColor: Colors.red,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.red,
  ),
);

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Brightness systemBrightness;

  @override
  void initState() {
    super.initState();
    systemBrightness = WidgetsBinding.instance.window.platformBrightness;

    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      setState(() {
        systemBrightness = WidgetsBinding.instance.window.platformBrightness;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(systemBrightness),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: getThemeDateFromThemeMode(state.mode, systemBrightness),
            home: ThemeSettingsScreen(),
          );
        },
      ),
    );
  }
}

ThemeData getThemeDateFromThemeMode(ThemeMode mode, Brightness systemBrightness) {
  switch (mode) {
    case ThemeMode.system:
      return systemBrightness == Brightness.light ? lightTheme : darkTheme;
    case ThemeMode.light:
      return lightTheme;
    case ThemeMode.dark:
      return darkTheme;
  }
}
