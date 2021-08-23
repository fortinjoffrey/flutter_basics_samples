import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'navigation/app_router.gr.dart';
import 'navigation/auth_guard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: App(),
    ),
  );
}

final _appRouter = AppRouter(authGuard: AuthGuard());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? locale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final previousLocale = locale;
    locale = context.locale;

    // Force all children to rebuild if the locale has changed
    if (previousLocale != locale) {
      rebuildAllChildren(context);
    }
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'autoroute-nested-navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // needed for autoroute navigation
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      // needed for easy localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
