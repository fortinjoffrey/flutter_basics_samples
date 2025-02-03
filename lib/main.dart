import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/packages/garage_view.dart';
import 'package:flutter_basics_samples/packages/user_connection/user_manager.dart';
import 'package:flutter_basics_samples/pages/user_info_page.dart';
import 'package:get_it/get_it.dart';

import 'packages/user_connection/user_connection_widget.dart';
import 'packages_core/core_http_client.dart';

Future<void> initDependencies() async {
  final locator = GetIt.instance;

  locator.registerSingleton<TokenProvider>(TokenProviderImpl());

  // Initialisation du UserManagerSDK avec le tokenProvider
  UserManagerSDK.initialize(locator.get<TokenProvider>());
}

void main() {
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    UserManagerSDK.instance.userStream.listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, '/garage_page');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      onGenerateInitialRoutes: (initialRoute) {
        if (initialRoute == '/login') {
          return [MaterialPageRoute(builder: (context) => UserConnectionWidget())];
        }
        return null;
      },
      routes: {
        '/login': (context) => UserConnectionWidget(
            // onSuccess: () {
            //   Navigator.pushNamed(context, '/user_info_page');
            // },
            // onError: () {},
            ),
        '/user_info_page': (context) => const UserInfoPage(),
        '/garage_page': (context) => GaragePage(
              tokenProvider: GetIt.instance.get(),
              vehicleIds: [],
            ),
      },
    );
  }
}
