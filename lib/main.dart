import 'package:basics_samples/fake_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? htmlData;

  @override
  Widget build(BuildContext context) {
    final Widget? html = htmlData == null
        ? null
        : Html(
            data: htmlData,
            style: {
              'p': Style.fromTextStyle(
                Theme.of(context).textTheme.bodyText2!,
              ).copyWith(color: Colors.black),
              'h1': Style(color: Colors.blue),
              'i': Style(color: Colors.green),
            },
          );
    return Scaffold(
      appBar: AppBar(
        title: Text('Html'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Standard flutter Text with bodyText2 style',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Package HTML example'),
            ),
            Html(
              data: """<div>
              <h1>Demo Page</h1>
              <p>This is a fantastic product that you should buy!</p>
              <h3>Features</h3>
              <ul>
                <li>It actually works</li>
                <li>It exists</li>
                <li>It doesn't cost much!</li>
              </ul>
              <!--You can pretty much put any html in here!-->
            </div>""",
            ),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            if (html != null) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text('My HTML example extracted from a word document exported as .html'),
              ),
              html,
            ],
            ElevatedButton(
              onPressed: () async {
                final result = await FakeDataSource().getHtmlData();
                setState(() {
                  htmlData = result;
                });
              },
              child: const Text('Get html data'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  htmlData = null;
                });
              },
              child: const Text('Reset html data'),
            ),
          ],
        ),
      ),
    );
  }
}
