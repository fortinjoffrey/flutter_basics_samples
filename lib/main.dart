import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                      final DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Date formatters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context) {
                  final now = DateTime.now();
                  return Text('DateTime.now() = $now');
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  // final DateTime now = DateTime.now().subtract(const Duration(days: 50));
                  final DateFormat formatter = DateFormat('EEEE hh:mm');
                  final String formatted = formatter.format(now);
                  print(formatted);
                  return Text('DateFormat(\'EEEE hh:mm\') = $formatted');
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  final DateFormat formatter = DateFormat.E();
                  final String formatted = formatter.format(now);
                  print(formatted);
                  return Text('DateFormat.E() = $formatted');
                },
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  final DateFormat formatter = DateFormat.MMMMEEEEd();
                  final String formatted = formatter.format(now);
                  print(formatted);
                  return Text('DateFormat.MMMMEEEEd() = $formatted');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
