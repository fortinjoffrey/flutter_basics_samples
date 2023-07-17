import 'package:basics_samples/widget_to_image.dart';
import 'package:basics_samples/widget_to_image_utils.dart';
import 'package:flutter/foundation.dart';
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _cardKey = GlobalKey();

  Uint8List? generatedImageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Widget',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 24),
              WidgetToImage(
                builder: (key) {
                  _cardKey = key;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 120.0,
                            child: Image.network(
                              'https://docs.flutter.dev/assets/images/dash/Dashatars.png',
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title', style: Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 16),
                                Text('Subtitle'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Image',
                style: Theme.of(context).textTheme.headline2,
              ),
              if (generatedImageBytes != null) ...[
                const SizedBox(height: 24),
                Image.memory(generatedImageBytes!),
              ],
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.lightBlue[100],
        height: 100,
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              final Uint8List? bytes = await WidgetToImageUtil.capture(_cardKey);

              setState(() {
                generatedImageBytes = bytes;
              });
            },
            child: const Text('Capture'),
          ),
        ),
      ),
    );
  }
}
