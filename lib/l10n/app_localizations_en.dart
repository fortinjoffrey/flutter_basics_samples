import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get counter => 'You have pushed the button this many times:';

  @override
  String get language_en => '🇬🇧 English';

  @override
  String get language_fr => '🇫🇷 French';

  @override
  String get change_language_title => 'Change Language Demo';

  @override
  String get increment => 'Increment';
}
