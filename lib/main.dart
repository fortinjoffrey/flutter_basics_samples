import 'package:basics_samples/cubits/auth/auth_cubit.dart';
import 'package:basics_samples/cubits/preferences/preferences_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

const isUserLoggedInKey = 'isUserLoggedIn';
const showOnboardingKey = 'showOnboarding';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(sharedPreferences),
        ),
        BlocProvider<PreferencesCubit>(
          create: (context) => PreferencesCubit(sharedPreferences),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
        redirect: (context, state) {
          final showOnboarding = context.read<PreferencesCubit>().state.showOnboarding;

          if (showOnboarding) return '/onboarding';

          final isUserLoggedIn = context.read<AuthCubit>().state.isUserLoggedIn;

          log('subloc: ${state.subloc}', name: 'redirect', time: DateTime.now());

          if (!isUserLoggedIn && state.subloc != '/login') {
            log('redirecting to: \'/login', name: 'redirect', time: DateTime.now());
            return '/login';
          }

          return null;
        },
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
        routes: [],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/home/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (!state.isUserLoggedIn) {
              context.go('/login');
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/login/settings');
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isUserLoggedIn) {
              context.go('/home');
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().login();
            },
            child: const Text('Login'),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding'),
      ),
      body: Center(
        child: BlocListener<PreferencesCubit, PreferencesState>(
          listener: (context, state) {
            if (!state.showOnboarding) {
              context.go('/home');
            }
          },
          child: ElevatedButton(
            onPressed: () {
              context.read<PreferencesCubit>().onboardingDone();
            },
            child: const Text('Done'),
          ),
        ),
      ),
    );
  }
}
