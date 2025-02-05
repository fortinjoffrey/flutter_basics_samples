import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/blocs/user_bloc.dart';
import 'package:flutter_basics_samples/blocs/user_bloc_state.dart';
import 'package:flutter_basics_samples/core/service_locator.dart';
import 'package:flutter_basics_samples/packages/garage/garage_manager.dart';
import 'package:flutter_basics_samples/packages/garage/widgets/garage_page.dart';
import 'package:flutter_basics_samples/packages/user_auth/models/user.dart';
import 'package:flutter_basics_samples/packages/user_auth/user_auth_manager.dart';
import 'package:flutter_basics_samples/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'packages/user_auth/widgets/user_connection_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserAuthManager.initialize();
  await GarageManager.initialize();

  await initDependencies();

  final User? currentUser = UserAuthManager.instance.currentUser;

  print('currentUser: $currentUser');

  runApp(MyApp(currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.currentUser});

  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(currentUser: currentUser),
      child: BlocListener<UserBloc, UserBlocState>(
        listenWhen: (previous, current) {
          return current is UserUnauthenticated && previous is UserAuthenticated ||
              current is UserAuthenticated && previous is UserUnauthenticated;
        },
        listener: (context, state) {
          if (state is UserUnauthenticated) {
            navigatorKey.currentState?.pushReplacementNamed('/login');
          } else if (state is UserAuthenticated) {
            navigatorKey.currentState?.pushReplacementNamed('/home');
          }
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Flutter Demo',
          // theme: ThemeData(useMaterial3: true),
          initialRoute: currentUser != null ? '/home' : '/login',
          routes: {
            '/login': (context) => const UserLoginInvitationPage(),
            '/home': (context) => const HomePage(),
            '/garage_page': (context) => GaragePage(),
          },
        ),
      ),
    );
  }
}
