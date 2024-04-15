# flutter_basics_samples

## Run maestro on iOS simulator

flutter build ios --debug --simulator
xcrun simctl install Booted Runner.app
maestro test check_counter_increment

## Run maestro on Android emulator
flutter build apk --debug
adb install build/app/outputs/flutter-apk/app-debug.apk
maestro test check_counter_increment.yaml

