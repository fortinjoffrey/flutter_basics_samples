import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
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
      initialRoute: 'home',
      onGenerateRoute: (RouteSettings settings) {
        final name = settings.name;
        if (name == 'home') {
          return MaterialPageRoute(builder: (context) => Home());
        } else if (name == 'red') {
          return MaterialPageRoute(builder: (context) => RedView());
        } else if (name == 'green') {
          return MaterialPageRoute(builder: (context) => GreenView());
        } else if (name == 'purple') {
          return CupertinoPageRoute(builder: (context) => PurpleView());
        }
        return MaterialPageRoute(
          builder: (context) => Center(child: Text('Error view')),
        );
      },
      // routes: {
      //   'home': (context) => Home(),
      //   'red': (context) => RedView(),
      //   'green': (context) => GreenView(),
      //   'purple': (context) => PurpleView(),
      // },
    );
  }
}

class PurpleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purple 4'),
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: ElevatedButton(
            child: Text('Pop'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    );
  }
}

class RedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Red 3'),
      ),
      body: Container(
        color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Push and replace purple view'),
                onPressed: () => Navigator.of(context).pushReplacementNamed('purple'),
              ),
              ElevatedButton(
                child: Text('Push purple and replace until home'),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    'purple',
                    ModalRoute.withName('home'),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Pop until home'),
                onPressed: () {
                  Navigator.of(context).popUntil(
                    ModalRoute.withName('home'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Green 2'),
      ),
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Pop'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text('Push red view'),
                onPressed: () => Navigator.of(context).pushNamed('red'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home 1'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Push green view'),
          onPressed: () => Navigator.of(context).pushNamed('green'),
        ),
      ),
    );
  }
}
