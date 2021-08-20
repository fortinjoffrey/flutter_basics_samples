import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:basics_samples/remote_source.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final streamController = StreamController<double>();

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  Future<void> _saveFileToDownloadFolder({
    required BuildContext context,
    required Uint8List fileBytes,
    required String filename,
  }) async {
    final Directory? directory = await getExternalStorageDirectory();

    if (directory == null) {
      throw 'getExternalStorageDirectory failed';
    }

    final splitted = directory.path.split('/');
    final index = splitted.indexWhere((element) => element == 'Android');
    final parts = splitted.getRange(0, index).toList();
    parts.add('Download');
    final path = parts.join('/');

    final file = File('$path/$filename');

    await file.writeAsBytes(fileBytes);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('File downloaded')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<double>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final percentage = (snapshot.data! * 100).toInt();
                  return Text(
                    '$percentage %',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            ElevatedButton(
              child: Text('Download flutter dash'),
              onPressed: () async {
                final remoteSource = RemoteSource();

                try {
                  // (step 1): check if we have permission to storage
                  if (!await Permission.storage.isGranted) {
                    final status = await Permission.storage.request();

                    if (status != PermissionStatus.granted) {
                      return;
                    }
                  }

                  // (step 2): once the permission is granted, download the file
                  final fileBytes = await remoteSource.downloadFromUrl(
                    'https://flutter.dev/assets/dash/early-dash-sketches2-a38190f3c27f9309101e711143e4a67af04757d7b9f29b00e9ae8cb2cb841d1a.jpg',
                    streamController,
                  );

                  // (step 3): save the file into the download folder
                  await _saveFileToDownloadFolder(context: context, fileBytes: fileBytes, filename: 'dash.jpg');
                } catch (e) {
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occured')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
