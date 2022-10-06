import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests Semantics demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              key: const Key('one'),
              onPressed: () {},
              child: const Text('No announcement'),
            ),
            ElevatedButton(
              key: const Key('two'),
              onPressed: () {
                SemanticsService.announce('Hello there', TextDirection.ltr);
              },
              child: const Text('Hello there (1 announcement)'),
            ),
            ElevatedButton(
              key: const Key('three'),
              onPressed: isLoading
                  ? null
                  : () async {
                      SemanticsService.announce('Fetching data', TextDirection.ltr);
                      setState(() {
                        isLoading = true;
                      });
                      await Future<void>.delayed(const Duration(seconds: 2));
                      SemanticsService.announce('Data fetched', TextDirection.ltr);
                      setState(() {
                        isLoading = false;
                      });
                    },
              child: isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(strokeWidth: 1),
                    )
                  : const Text('Fetching data (2 announcements)'),
            ),
          ],
        ),
      ),
    );
  }
}
