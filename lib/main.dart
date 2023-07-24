import 'package:basics_samples/components/draggable_text.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

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
  List<SelectableDraggableWidget> texts = [];
  bool isDragging = false;
  final _stackKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createDraggableText(top: 20);
    _createDraggableIcon(top: 50);
  }

  void selectUnselectWidget({
    required String id,
    required bool isSelected,
  }) {
    final updatedTexts = texts
        .map(
          (widget) => SelectableDraggableWidget(
            id: widget.id,
            onTap: widget.onTap,
            onDragEnd: widget.onDragEnd,
            top: widget.top,
            left: widget.left,
            isSelected: false,
            child: widget.child,
          ),
        )
        .toList();

    final selectedTextIndex = updatedTexts.indexWhere((widget) => widget.id == id);
    if (selectedTextIndex == -1) return;
    final selectedWidget = updatedTexts[selectedTextIndex];

    updatedTexts[selectedTextIndex] = SelectableDraggableWidget(
      id: selectedWidget.id,
      onTap: selectedWidget.onTap,
      onDragEnd: selectedWidget.onDragEnd,
      top: selectedWidget.top,
      left: selectedWidget.left,
      isSelected: true,
      child: selectedWidget.child,
    );

    setState(() {
      texts = updatedTexts;
    });
  }

  void _createDraggableText({
    double? top,
    double? left,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(DraggableText(
      id: uuid,
      onTap: () => selectUnselectWidget(id: uuid, isSelected: true),
      onDragEnd: (details) {
        if (texts.firstWhereOrNull((element) => element.id == uuid) == null) return;

        print(details.offset);

        final renderBox = _stackKey.currentContext?.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        setState(() {
          isDragging = false;
          // Pas
          texts.removeWhere((element) => element.id == uuid);
          _createDraggableText(
            top: details.offset.dy - offset.dy,
            left: details.offset.dx - offset.dx,
            isSelected: true,
          );
        });
      },
      top: top ?? 20,
      left: left ?? null,
      isSelected: isSelected,
    ));
  }

  void _createDraggableIcon({
    double? top,
    double? left,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(DraggableIcon(
      id: uuid,
      onTap: () => selectUnselectWidget(id: uuid, isSelected: true),
      onDragEnd: (details) {
        if (texts.firstWhereOrNull((element) => element.id == uuid) == null) return;

        print(details.offset);

        final renderBox = _stackKey.currentContext?.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        setState(() {
          isDragging = false;
          texts.removeWhere((element) => element.id == uuid);
          _createDraggableIcon(
            top: details.offset.dy - offset.dy,
            left: details.offset.dx - offset.dx,
          );
        });
      },
      top: top ?? 20,
      left: left ?? null,
      isSelected: isSelected,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Container(
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
                      child: DragTarget<String>(
                        onWillAccept: (id) {
                          return texts.firstWhereOrNull(
                                (widget) {
                                  final isEqual = widget.id == id;
                                  return isEqual;
                                },
                              ) !=
                              null;
                        },
                        onAccept: (id) {
                          setState(() {
                            texts.removeWhere((element) => element.id == id);
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null,
                onTap: () {
                  print('onTextFieldTap');
                },
                onChanged: (text) {},
                decoration: InputDecoration(
                  hintText: 'Your name',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check),
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: texts.isEmpty
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _createDraggableText(top: 20);
                  _createDraggableIcon(top: 50);
                });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
