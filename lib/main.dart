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
          return MaterialPageRoute(settings: settings, builder: (context) => Home());
        } else if (name == 'red') {
          return MaterialPageRoute(settings: settings, builder: (context) => RedView());
        } else if (name == 'green') {
          return MaterialPageRoute(settings: settings, builder: (context) => GreenView());
        } else if (name == 'purple') {
          return CupertinoPageRoute(settings: settings, builder: (context) => PurpleView());
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
                  Navigator.of(context, rootNavigator: true).popUntil(
                    (route) {
                      print(route.settings.name);
                      return route.settings.name == 'home';
                    },
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              final res = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Supprimer ?'),
                    content: Text('Etes vous sur ?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop<bool>(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop<bool>(true),
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              );
              print(res);
            },
            child: Text('Show Alert'),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('A snackbar appeared'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: Text('Show Snackbar'),
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Modal bottom sheet',
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                  );
                },
              );
            },
            child: Text('Show modal bottom sheet'),
          ),
          ElevatedButton(
            child: Text('Push green view'),
            onPressed: () => Navigator.of(context).pushNamed('green'),
          ),
        ],
      ),
    );
  }
}
