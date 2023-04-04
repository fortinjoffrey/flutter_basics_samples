import 'package:basics_samples/firebase_remote_config_manager.dart';
import 'package:basics_samples/get_color_from_hex_string.dart';
import 'package:basics_samples/versions_info_provider.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
// ignore: unused_import
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String currentAppVersionNumber = '2.3.0';
  // String currentAppVersionNumber = (await PackageInfo.fromPlatform()).version;

  final firebaseRemoteConfigManager = FirebaseRemoteConfigManager();
  await firebaseRemoteConfigManager.setupFirebaseRemoteConfig();
  final versionsInfoProvider = VersionsInfoProvider.parse(
    currentVersionStr: currentAppVersionNumber,
    latestAvailableVersionStr: firebaseRemoteConfigManager.latestVersionNumber,
    lastVersionWithBreakingChangesStr: firebaseRemoteConfigManager.lastVersionWithBreakingChangesNumber,
  );

  print(versionsInfoProvider.toString());

  GetIt.instance.registerLazySingleton<FirebaseRemoteConfigManager>(() => firebaseRemoteConfigManager);
  GetIt.instance.registerLazySingleton<VersionsInfoProvider>(() => versionsInfoProvider);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showUpdateDialog = GetIt.instance<VersionsInfoProvider>().updateAvailable;
    final latestAvailableVersion = GetIt.instance<VersionsInfoProvider>().latestAvailableVersionNumber;
    final updateInfoStatus = GetIt.instance<VersionsInfoProvider>().updateInfoStatus;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: showUpdateDialog
          ? UpdateAppDialog(
              latestAvailableVersion: latestAvailableVersion,
              updateInfoStatus: updateInfoStatus,
            )
          : MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class UpdateAppDialog extends StatelessWidget {
  const UpdateAppDialog({super.key, required this.latestAvailableVersion, required this.updateInfoStatus});

  final String latestAvailableVersion;
  final UpdateInfoStatus updateInfoStatus;

  @override
  Widget build(BuildContext context) {
    final updateMandatory = updateInfoStatus == UpdateInfoStatus.updateMandatory;

    return AlertDialog(
      title: SelectableText.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'A new version is available',
            ),
            if (updateMandatory) const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
      // title: Text('A new version is available${updateMandatory ? '*' : ''}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Please update to enjoy the lastest features avaible'),
          if (updateMandatory) ...[
            const SizedBox(height: 16),
            SelectableText.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '* ', style: TextStyle(color: Colors.red)),
                  TextSpan(
                    text: 'The update is mandatory in order to the best app experience',
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Update now'),
        ),
        if (updateInfoStatus == UpdateInfoStatus.updateNonMandatory)
          TextButton(
            onPressed: () {},
            child: const Text('Later'),
          ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late final Color appBarBgColor;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    final hexColorString = FirebaseRemoteConfig.instance.getString(FirebaseRemoteConfigKeys.appbarBackgroundColorKey);
    appBarBgColor = getColorfromHexString(hexColorString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
