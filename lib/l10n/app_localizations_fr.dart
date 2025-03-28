import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde!';

  @override
  String get counter => 'Vous avez appuyé sur le bouton ce nombre de fois:';

  @override
  String get language_en => '🇬🇧 Anglais';

  @override
  String get language_fr => '🇫🇷 Français';

  @override
  String get change_language_title => 'Changer la langue Demo';

  @override
  String get increment => 'Incrémenter';
}
