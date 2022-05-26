import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

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
        title: Text('Share demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Share.share('Ipsum eiusmod qui officia nostrud pariatur.');
              },
              child: const Text('Share text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                const String url = 'https://www.youtube.com/';
                Share.share('Check out this link: $url');
              },
              child: const Text('Share text + link'),
            ),
            const SizedBox(height: 16),
            Image.network(
              'https://docs.flutter.dev/assets/images/dash/early-dash-sketches3.jpg',
              width: 200,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final String url = 'https://docs.flutter.dev/assets/images/dash/early-dash-sketches3.jpg';
                final Uri uri = Uri.parse(url);
                final http.Response response = await http.get(uri);

                if (response.statusCode != 200) {
                  return;
                }

                final Uint8List bytes = response.bodyBytes;

                final Directory tempDir = await getTemporaryDirectory();
                final String uuid = Uuid().v4();
                final String path = '${tempDir.path}/$uuid.jpg';
                File(path).writeAsBytesSync(bytes);

                await Share.shareFiles([path]);
              },
              child: const Text('Share images'),
            ),
          ],
        ),
      ),
    );
  }
}
