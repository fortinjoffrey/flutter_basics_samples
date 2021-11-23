import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DummyView(),
                ),
              );
            },
            child: const Text('Push view'),
          ),
        ),
      ),
    );
  }
}

class DummyView extends StatefulWidget {
  DummyView({Key? key}) : super(key: key);

  @override
  _DummyViewState createState() => _DummyViewState();
}

class _DummyViewState extends State<DummyView> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    print('initState');
    super.initState();
  }

  @override
  void didPush() {
    print('didPush');
    super.didPush();
  }

  @override
  void didPop() {
    print('didPop');
    super.didPop();
  }

  @override
  void dispose() {
    print('dispose');
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy'),
      ),
      body: Container(color: Colors.red),
    );
  }
}
