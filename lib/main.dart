import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final login = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Theme.of(context).primaryColor,
          child: const Text("Login"),
          onPressed: () {
            login.login();
          },
        ),
      ),
    );
  }
}
