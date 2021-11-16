import 'package:basics_samples/services/preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/onboarding/onboarding_view.dart';

late final PreferencesService preferencesService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  preferencesService = PreferencesService(sharedPreferences);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Color(0xFFEC6B06),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    if (preferencesService.showOnboarding) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) async {
          await _showOnboardingModal();
          // only show the onboarding on first launch
          preferencesService.showOnboarding = false;
        },
      );
    }
  }

  Future<void> _showOnboardingModal() async {
    await showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      isScrollControlled: true,
      builder: (_) => const OnboardingView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => preferencesService.showOnboarding = true,
              child: const Text('Reset onboarding preference'),
            ),
            ElevatedButton(
              onPressed: () => _showOnboardingModal(),
              child: const Text('Show onboarding'),
            ),
          ],
        ),
      ),
    );
  }
}
