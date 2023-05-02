import 'package:basics_samples/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

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
  int _counter = 0;

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
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
              onPressed: () async {
                await FirebaseAnalytics.instance.logBeginCheckout(
                    value: 10.0,
                    currency: 'USD',
                    items: [
                      AnalyticsEventItem(itemName: 'Socks', itemId: 'xjw73ndnw', price: 10),
                    ],
                    coupon: '10PERCENTOFF');
              },
              child: const Text('Log begin_checkout'),
            ),
            ElevatedButton(
              onPressed: () async {
                _incrementCounter();
                await FirebaseAnalytics.instance.logEvent(
                  name: "increment_count",
                  parameters: {
                    "content_type": "foo",
                    "item_id": 'bar',
                  },
                );
              },
              child: const Text('Log increment_count'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
