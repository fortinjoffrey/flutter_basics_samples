import 'package:basics_samples/view_with_transparent_background.dart';
import 'package:basics_samples/transparent_page_route.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Push view with transparent background with:'),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    TransparentPageRoute(
                      builder: (context, animation, secondaryAnimation) {
                        return ViewWithTransparentBackground();
                      },
                    ),
                  );
                },
                child: const Text('Platform transition'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    TransparentPageRoute(
                      useMaterialTransition: true,
                      builder: (context, animation, secondaryAnimation) {
                        return ViewWithTransparentBackground();
                      },
                    ),
                  );
                },
                child: const Text('Material transition'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    TransparentPageRoute(
                      useCupertinoTransition: true,
                      builder: (context, animation, secondaryAnimation) {
                        return ViewWithTransparentBackground();
                      },
                    ),
                  );
                },
                child: const Text('Cupertino transition'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
