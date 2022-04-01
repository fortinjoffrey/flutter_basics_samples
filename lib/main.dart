import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Scroll to widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final blueKey = GlobalKey();
  final scrollKey = GlobalKey();
  final appBarKey = GlobalKey();
  final greenKey = GlobalKey();
  final yellowKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      RenderBox box = blueKey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero); //this is global position
      double y = position.dy;
      print('Blue container y value = $y');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        key: scrollKey,
        controller: _scrollController,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                color: Colors.red,
              ),
              ElevatedButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Press to scroll to bottom'),
              ),
              Container(
                key: blueKey,
                height: 300,
                color: Colors.blue,
              ),
              ElevatedButton(
                onPressed: () {
                  scrollToWidget(yellowKey, _scrollController);
                },
                child: const Text('Press to scroll to yellow'),
              ),
              Container(
                key: greenKey,
                height: 300,
                color: Colors.green,
              ),
              Container(
                height: 300,
                color: Colors.cyan,
              ),
              ElevatedButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('Press to scroll to top'),
              ),
              Container(
                key: yellowKey,
                height: 300,
                color: Colors.yellow,
              ),
              ElevatedButton(
                onPressed: () {
                  scrollToWidget(blueKey, _scrollController);
                },
                child: const Text('Press to scroll to blue'),
              ),
              ElevatedButton(
                onPressed: () {
                  scrollToWidget(greenKey, _scrollController);
                },
                child: const Text('Press to scroll to green'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double? getAbsoluteWidgetYPosition(GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    final Offset? position = box?.localToGlobal(Offset.zero); //this is global position
    return position?.dy;
  }

  void scrollToWidget(
    GlobalKey key,
    ScrollController scrollController, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    final widgetY = getAbsoluteWidgetYPosition(key);
    final appBarHeight = appBarKey.currentContext?.size?.height;

    if (widgetY == null) return;
    if (appBarHeight == null) return;

    final scrollY = _scrollController.offset;
    final pixelsToScroll = scrollY + widgetY - appBarHeight;

    _scrollController.animateTo(
      pixelsToScroll,
      duration: duration,
      curve: Curves.easeInOut,
    );
  }
}
