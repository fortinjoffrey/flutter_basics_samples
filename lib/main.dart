import 'package:basics_samples/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: locale,
      localizationsDelegates: [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: I18n.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'l10n',
        onLocaleChangeAsked: (String languageCode) {
          setState(() => locale = Locale(languageCode));
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.onLocaleChangeAsked,
  }) : super(key: key);

  final String title;
  final ValueChanged<String> onLocaleChangeAsked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => onLocaleChangeAsked('fr'),
              child: const Text('fr'),
            ),
            ElevatedButton(
              onPressed: () => onLocaleChangeAsked('en'),
              child: const Text('en'),
            ),
            ElevatedButton(
              onPressed: () => onLocaleChangeAsked('de'),
              child: const Text('de'),
            ),
            Text('Current locale: ${Localizations.localeOf(context).toString()}'),
            FooWidget(),
            Text(I18n.current.validation_errors_min_value(3)),
            Text(I18n.current.helloAndWelcome('John', 'Doe')),
            Text(I18n.current.newMessages(0)),
            Text(I18n.current.newMessages(1)),
            Text(I18n.current.newMessages(4)),
          ],
        ),
      ),
    );
  }
}

class FooWidget extends StatelessWidget {
  const FooWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(I18n.current.yes);
  }
}
