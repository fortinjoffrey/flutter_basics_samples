# l10n intl_utils package usage

This project shows on to implement a l10n solution using the intl_utils package

The app default locale is the system default. If the locale is not supported in the app, the en locale is used.
Application locale can be modified at runtime.

## 📦 Packages

- [x] intl
- [x] intl_utils

## Setup

1. Add intl dependency
2. Add intl_utils dev dependency
3. Use flutter_localizations from sdk: flutter
4. Create your arb files in lib/l10n named intl_LOCALE.dart (replace LOCALE by the desired locale intl_en.dart)
5. In each arb files set the locale for ```@@locale``` key
6. Generate l10n intl files

### To regenerate l10n intl files

```dart
fvm flutter pub run intl_utils:generate
```

### arb files example (intl_en.arb)

```arb
{
  "@@locale": "en",
  "yes": "yes"
}
```

## 🚀 Demo

https://github.com/fortinjoffrey/flutter_basics_samples/assets/36731875/20c94502-3137-4e1f-b295-a42223f4440e
