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
  final _selectedElementKey = GlobalKey();
  Size? _selectedElementSize;
  final textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createDraggableText(bottom: 200, title: 'Drag me too');
    _createDraggableIcon(top: 50);
  }

  void unselectedCurrentSelectedWidget({bool performSetState = true}) {
    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((widget) => widget.isSelected);
    if (selectedWidgetIndex != -1) {
      updatedTexts[selectedWidgetIndex] = updatedTexts[selectedWidgetIndex].copyWith(isSelected: false);
    }
    if (performSetState) setState(() => texts = updatedTexts);
  }

  void recomputeSelectedElementSize() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final elementSize = _selectedElementKey.currentContext?.size;
      _selectedElementSize = elementSize;
    });
  }

  void selectUnselectWidget({
    required String id,
    required bool isSelected,
  }) {
    unselectedCurrentSelectedWidget(performSetState: false);

    var updatedTexts = texts;
    if (isSelected) {
      final widgetToUpdateIndex = updatedTexts.indexWhere((widget) => widget.id == id);
      if (widgetToUpdateIndex != -1) {
        updatedTexts = texts.map((e) => e.copyWith(key: null)).toList();

        final updatedText = updatedTexts[widgetToUpdateIndex].copyWith(
          key: _selectedElementKey,
          isSelected: true,
        );

        recomputeSelectedElementSize();

        updatedTexts.removeAt(widgetToUpdateIndex);
        updatedTexts.add(updatedText);

        setState(() {
          isDragging = false;
          texts = updatedTexts;
        });

        if (updatedTexts.hasTextSelected) {
          final title = updatedTexts[widgetToUpdateIndex].title;
          if (title != null) {
            textEditingController.value = TextEditingValue(
              text: updatedTexts[widgetToUpdateIndex].title ?? '',
              selection: TextSelection(baseOffset: title.length, extentOffset: title.length),
            );
          }
        }
      }
    }

    setState(() => texts = updatedTexts);
  }

  bool isElementDraggedInside({
    required Offset parentOffset,
    required Size parentSize,
    required Offset childOffset,
    required Size childSize,
  }) {
    final parentXstart = parentOffset.dx;
    final parentXend = parentOffset.dx + parentSize.width;
    final parentYstart = parentOffset.dy;
    final parentYend = parentOffset.dy + parentSize.height;

    final aOffset = childOffset;
    final bOffset = Offset(childOffset.dx + childSize.width, childOffset.dy);
    final cOffset = Offset(childOffset.dx + childSize.width, childOffset.dy + childSize.height);
    final dOffset = Offset(childOffset.dx, childOffset.dy + childSize.height);

    final points = [aOffset, bOffset, cOffset, dOffset];

    for (final point in points) {
      if (point.dx > parentXstart && point.dx < parentXend && point.dy > parentYstart && point.dy < parentYend) {
        return true;
      }
    }

    return false;
  }

  void _createDraggableText({
    double? bottom,
    // double? top,
    double? left,
    required String title,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(SelectableDraggableWidget.text(
      title: title,
      id: uuid,
      onTap: () => selectUnselectWidget(id: uuid, isSelected: true),
      onTapOutside: (tapPosition) {
        final stackContext = _stackKey.currentContext;
        final stackSize = stackContext?.size;
        if (stackContext == null || stackSize == null) return;

        final renderBox = stackContext.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        if ((offset.dx <= tapPosition.dx && tapPosition.dx <= (offset.dx + stackSize.width)) &&
            (offset.dy <= tapPosition.dy && tapPosition.dy <= (offset.dy + stackSize.height))) {
          // check if tap outside is within the stack
          selectUnselectWidget(id: uuid, isSelected: false);
        }
      },
      onDragEnd: (details) {
        if (texts.firstWhereOrNull((element) => element.id == uuid) == null) return;
        final selectedElementSize = _selectedElementSize;
        if (selectedElementSize == null) return;

        final stackContext = _stackKey.currentContext;
        final stackSize = stackContext?.size;
        if (stackContext == null || stackSize == null) return;

        final stackRenderBox = stackContext.findRenderObject() as RenderBox;
        final stackOffset = stackRenderBox.localToGlobal(Offset.zero);

        final updatedTexts = texts;
        final selectedWidgetIndex = texts.indexWhere((element) => element.isSelected);

        if (selectedWidgetIndex == -1) return;

        // check if the text has been dragged outside of the stack
        // if so then replace it back to its original position
        // else move it

        if (isElementDraggedInside(
          parentOffset: stackOffset,
          parentSize: stackSize,
          childOffset: details.offset,
          childSize: selectedElementSize,
        )) {
          final updatedText = texts[selectedWidgetIndex].copyWith(
            // top: details.offset.dy - stackOffset.dy,
            left: details.offset.dx - stackOffset.dx,
            // bottom: 0,
            bottom: (stackOffset.dy + stackSize.height) - details.offset.dy - selectedElementSize.height,
          );
          updatedTexts.removeAt(selectedWidgetIndex);
          updatedTexts.add(updatedText);

          setState(() {
            isDragging = false;
            texts = updatedTexts;
          });
        } else {
          setState(() {
            isDragging = false;
          });
        }
      },
      top: null,
      left: left ?? null,
      bottom: bottom ?? null,
      isSelected: isSelected,
    ));
  }

  void _createDraggableIcon({
    double? top,
    double? left,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(SelectableDraggableWidget.icon(
      id: uuid,
      onTap: () => selectUnselectWidget(id: uuid, isSelected: true),
      onTapOutside: (tapPosition) {
        final stackContext = _stackKey.currentContext;
        final stackSize = stackContext?.size;
        if (stackContext == null || stackSize == null) return;

        final renderBox = stackContext.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        if ((offset.dx <= tapPosition.dx && tapPosition.dx <= (offset.dx + stackSize.width)) &&
            (offset.dy <= tapPosition.dy && tapPosition.dy <= (offset.dy + stackSize.height))) {
          // check if tap outside is within
          selectUnselectWidget(id: uuid, isSelected: false);
        }
      },
      onDragEnd: (details) {
        if (texts.firstWhereOrNull((element) => element.id == uuid) == null) return;

        final renderBox = _stackKey.currentContext?.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        setState(() {
          isDragging = false;
          texts.removeWhere((element) => element.id == uuid);
          _createDraggableIcon(
            top: details.offset.dy - offset.dy,
            left: details.offset.dx - offset.dx,
            isSelected: true,
          );
        });
      },
      top: top ?? 20,
      left: left ?? null,
      bottom: null,
      isSelected: isSelected,
      iconData: Icons.hardware,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: 500,
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
            ),
            const SizedBox(height: 16),
            Container(
              // height: 200,
              color: Colors.green,
              child: texts.hasTextSelected
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: textEditingController,
                            maxLines: null,
                            onTap: () {
                              print('onTextFieldTap');
                            },
                            onChanged: (text) {
                              final updatedTexts = texts;
                              final selectedWidgetIndex = texts.indexWhere((element) => element.isSelected);

                              if (selectedWidgetIndex == -1) return;

                              final updatedText = texts[selectedWidgetIndex].copyWith(title: text);
                              updatedTexts[selectedWidgetIndex] = updatedText;

                              setState(() => texts = updatedTexts);
                            },
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
                        if (MediaQuery.of(context).viewInsets.bottom == 0)
                          Container(
                            color: Colors.amber,
                            height: 200,
                          )
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            // if (texts.hasTextSelected)
            ElevatedButton(
              onPressed: () {
                textEditingController.value = TextEditingValue(
                  text: '',
                  selection: TextSelection(baseOffset: 0, extentOffset: 0),
                );
                unselectedCurrentSelectedWidget();
                setState(() {
                  _createDraggableText(isSelected: true, title: '');
                });
              },
              child: const Text('Add Text'),
            ),
          ],
        ),
      ),
    );
  }
}

extension on List<SelectableDraggableWidget> {
  bool get hasTextSelected {
    final selectedWidgetIndex =
        this.indexWhere((widget) => widget.isSelected && widget.type == SelectableDraggableWidgetType.text);
    return selectedWidgetIndex != -1;
  }

  bool get hasWidgetSelected {
    final selectedWidgetIndex = this.indexWhere((widget) => widget.isSelected);
    return selectedWidgetIndex != -1;
  }
}
