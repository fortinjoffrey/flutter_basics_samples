import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: true,
      useOnlyLangCode: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    print('title'.tr());

    print(context.locale.toString());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(
            () {
              _count++;
            },
          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            LocaleKeys.title.tr(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
          ),
          Text('${LocaleKeys.current_locale.tr()}: ${context.locale}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.setLocale(Locale('en'));
                },
                child: Text('EN'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.setLocale(Locale('fr'));
                },
                child: Text('FR'),
              ),
            ],
          ),
          Text(
            LocaleKeys.counter.plural(_count),
          ),
        ],
      ),
    );
  }
}
