generated:
	flutter packages pub run build_runner build

generated-delete:
	flutter packages pub run build_runner build --delete-conflicting-outputs

translations:
	flutter pub run easy_localization:generate --source-dir assets/translations --source-file en.json --format keys --output-dir lib/l10n --output-file locale_keys.dart
  
