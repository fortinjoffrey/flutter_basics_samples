import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await rateMyAppInstance.reset();
  await rateMyAppInstance.init();
  runApp(MyApp());
}

final rateMyAppInstance = RateMyApp(
  googlePlayIdentifier: 'com.distime.distime',
  appStoreIdentifier: '6444045942',
  minLaunches: 10,
  remindLaunches: 3,
  minDays: 0,
  remindDays: 0,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (rateMyAppInstance.shouldOpenDialog) {
        if (mounted && rateMyAppInstance.shouldOpenDialog) {
          rateMyAppInstance.showRateDialog(
            context,
            barrierDismissible: true,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  rateMyAppInstance.showRateDialog(
                    context,
                    // barrierDismissible: true,
                    // barrierLabel: 'BARRIERLABEL',
                    // message: 'MESSAGE',
                    // title: 'TITLE',
                    // laterButton: 'LATER',
                    // rateButton: 'TOTO',
                    // noButton: 'NOBUTTON',
                    // message: "mes",
                    onDismissed: () {
                      print('onDismiss');
                    },

                    listener: (button) {
                      // The button click listener (useful if you want to cancel the click event).
                      switch (button) {
                        case RateMyAppDialogButton.rate:
                          print('Clicked on "Rate".');
                          break;
                        case RateMyAppDialogButton.later:
                          print('Clicked on "Later".');
                          break;
                        case RateMyAppDialogButton.no:
                          print('Clicked on "No".');
                          break;
                      }

                      return true; // Return false if you want to cancel the click event.
                    },
                  );
                },
                child: const Text('Show rate dialog')),
          ],
        ),
      ),
    );
  }
}
