import 'package:basics_samples/overlay_mixin.dart';
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
      home: MyHomePage(title: 'Flutter Demo Overlays'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with OverlayMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                showOverlay();

                await Future<void>.delayed(const Duration(seconds: 3));

                hideOverlay();
              },
              child: Text(
                'Show fullscreen overlay',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showOverlay(secondOverlayEntry);

                await Future<void>.delayed(const Duration(seconds: 3));

                hideOverlay(secondOverlayEntry);
              },
              child: Text(
                'Show bottom overlay',
              ),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry firstOverlayEntry = OverlayEntry(
    builder: (context) => Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: .5,
          child: Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
  OverlayEntry secondOverlayEntry = OverlayEntry(
    builder: (context) => Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: .3,
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    ),
  );

  @override
  List<OverlayEntry> get overlayEntries => [firstOverlayEntry, secondOverlayEntry];
}
