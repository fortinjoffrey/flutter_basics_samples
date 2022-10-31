import 'package:basics_samples/auth_bloc.dart';
import 'package:basics_samples/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Auth Bloc'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Auth Bloc Actions',
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(TokenExpired());
                },
                child: const Text('Token Expired'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoginRequested());
                },
                child: const Text('Login'),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String text;
                  switch (state) {
                    case AuthState.unauthenticated:
                      text = "Unauth";
                      break;
                    case AuthState.unknown:
                      text = "Unknown";
                      break;
                    case AuthState.authenticated:
                      text = "Auth";
                      break;
                  }
                  return Text(text);
                },
              ),
              Text(
                'Auth Cubit Actions',
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().tokenHasExpired();
                },
                child: const Text('Token Expired'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().login();
                },
                child: const Text('Login'),
              ),
              BlocBuilder<AuthCubit, AuthCubitState>(
                builder: (context, state) {
                  String text;
                  switch (state) {
                    case AuthCubitState.unauthenticated:
                      text = "Unauth";
                      break;
                    case AuthCubitState.unknown:
                      text = "Unknown";
                      break;
                    case AuthCubitState.authenticated:
                      text = "Auth";
                      break;
                  }
                  return Text(text);
                },
              ),
            ],
          ),
        ));
  }
}
