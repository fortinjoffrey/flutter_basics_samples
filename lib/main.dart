import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                launchUrlInDefaultBrowser(url: 'https://flutter.dev');
              },
              child: Text(
                'Open Flutter website in default browser',
              ),
            ),
            TextButton(
              onPressed: () async {
                launchUrlInDefaultBrowser(url: 'https://twitter.com/FlutterDev');
              },
              child: Text(
                'Open Flutter twitter page in default browser',
              ),
            ),
            TextButton(
              onPressed: () async {
                launchUrlInDefaultBrowser(
                  url: 'https://flutter.dev',
                  launchMode: LaunchMode.inAppWebView, 
                );
              },
              child: Text(
                'Open Flutter website in app web view',
              ),
            ),
            TextButton(
              onPressed: () async {
                launchUrlInDefaultBrowser(
                  url: 'https://twitter.com/FlutterDev',
                  launchMode: LaunchMode.inAppWebView,
                );
              },
              child: Text(
                'Open Flutter twitter page in app web view',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> launchUrlInDefaultBrowser({
  required String url,
  LaunchMode launchMode = LaunchMode.externalApplication,
}) async {
  final Uri _url = Uri.parse(url);

  if (await canLaunchUrl(_url)) {
    launchUrl(
      _url,
      mode: launchMode,
    );
  }
}
