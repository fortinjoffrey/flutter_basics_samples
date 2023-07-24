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
      home: MyHomePage(title: 'Draggable Text'),
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
  List<Widget> texts = [];
  bool isDragging = false;
  final _stackKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createDraggableText();
  }

  void _createDraggableText({double? top, double? left}) {
    texts.add(
      Positioned(
        top: top ?? 20,
        left: left ?? null,
        child: Draggable(
          data: true,
          childWhenDragging: const SizedBox.shrink(),
          onDragStarted: () {
            setState(() {
              isDragging = true;
            });
          },
          onDragEnd: (details) {
            print(details.offset);

            final renderBox = _stackKey.currentContext?.findRenderObject() as RenderBox;
            final offset = renderBox.localToGlobal(Offset.zero);

            setState(() {
              isDragging = false;
              if (texts.isNotEmpty) {
                texts = [];
                _createDraggableText(
                  top: details.offset.dy - offset.dy,
                  left: details.offset.dx - offset.dx,
                );
              }
            });
          },
          feedback: Material(
            color: Colors.transparent,
            child: Text('Drag me'),
          ),
          child: GestureDetector(
            onTap: () {
              print('Tapped');
            },
            child: Container(
              child: Text('Drag me'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 500,
          color: Colors.grey[200],
          child: Stack(
            key: _stackKey,
            alignment: Alignment.center,
            children: <Widget>[
              ...texts,
              // if (isDragging)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: DragTarget<bool>(
                    onWillAccept: (data) {
                      return data == true;
                    },
                    onAccept: (data) {
                      print('onAccept');
                      setState(() {
                        texts = [];
                      });
                    },
                    onLeave: (data) {
                      print('onLeave');
                    },
                    builder: (context, candidates, rejects) {
                      final hasCandidates = candidates.isNotEmpty;

                      return CircleAvatar(
                        backgroundColor: hasCandidates ? Colors.red : Colors.blue,
                        radius: 20,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: texts.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _createDraggableText();
                });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
