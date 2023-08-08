import 'package:basics_samples/components/draggable_text.dart';
import 'package:basics_samples/utils/offset_utils.dart';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:quiver/pattern.dart';
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
  final textEditingController = TextEditingController();
  double? initExpandedHeight;
  final _bottomSectionKey = GlobalKey();
  Size? _currentDraggedElementSize;

  @override
  void initState() {
    super.initState();
    _createDraggableText(top: 200, title: 'Drag me too');
    _createDraggableIcon(top: 50);
  }

  void changeTextStyle({
    double? fontSize,
    Color? fontColor,
  }) {
    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((widget) => widget.isSelected);
    if (selectedWidgetIndex != -1) {
      updatedTexts[selectedWidgetIndex] = updatedTexts[selectedWidgetIndex].copyWith(
        fontSize: fontSize != null ? Optional.fromNullable(fontSize) : null,
        fontColor: fontColor != null ? Optional.fromNullable(fontColor) : null,
      );
    }
    setState(() => texts = updatedTexts);
  }

  void unselectedCurrentSelectedWidget({bool performSetState = true}) {
    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((widget) => widget.isSelected);
    if (selectedWidgetIndex != -1) {
      final SelectableDraggableWidget selectedWidget = updatedTexts[selectedWidgetIndex];

      if (selectedWidget.isText && selectedWidget.title?.isEmpty == true) {
        updatedTexts.removeAt(selectedWidgetIndex);
      } else {
        updatedTexts[selectedWidgetIndex] = selectedWidget.copyWith(isSelected: false);
      }
    }
    if (performSetState) setState(() => texts = updatedTexts);
  }

  void _onDragEnd({
    required DraggableDetails details,
    required String uuid,
  }) {
    final selectedElement = texts.firstWhereOrNull((element) => element.id == uuid);

    if (selectedElement == null) return;

    final selectedElementSize = _currentDraggedElementSize;

    print('selectedElementSize= $selectedElementSize');

    if (selectedElementSize == null) return;

    final stackContext = _stackKey.currentContext;
    final stackSize = stackContext?.size;
    if (stackContext == null || stackSize == null) return;

    final stackRenderBox = stackContext.findRenderObject() as RenderBox;
    final stackOffset = stackRenderBox.localToGlobal(Offset.zero);

    final bottomSectionContext = _bottomSectionKey.currentContext;
    final bottomSectionSize = bottomSectionContext?.size;
    if (bottomSectionContext == null || bottomSectionSize == null) return;

    final bottomSectionRenderBox = bottomSectionContext.findRenderObject() as RenderBox;
    final bottomSectionOffset = bottomSectionRenderBox.localToGlobal(Offset.zero);

    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((element) => element.id == uuid);

    if (selectedWidgetIndex == -1) return;

    // check if the text has been dragged outside of the stack
    // if so then replace it back to its original position
    // else move it

    final isElementDraggedInStack = OffsetUtils.isElementDraggedInsideParent(
      parentOffset: stackOffset,
      parentSize: stackSize,
      childOffset: details.offset,
      childSize: selectedElementSize,
    );

    final isElementDraggedInBottomSection = OffsetUtils.isElementDraggedInsideParent(
      parentOffset: bottomSectionOffset,
      parentSize: bottomSectionSize,
      childOffset: details.offset,
      childSize: selectedElementSize,
    );

    _currentDraggedElementSize = null;

    if (!isElementDraggedInBottomSection && isElementDraggedInStack) {
      final updatedText = texts[selectedWidgetIndex].copyWith(
        top: details.offset.dy - stackOffset.dy,
        left: details.offset.dx - stackOffset.dx,
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
  }

  void onElementDragStarted({
    required String uuid,
  }) {
    FocusScope.of(context).unfocus();
    final selectedElement = texts.firstWhereOrNull((element) => element.id == uuid);

    if (selectedElement == null) return;

    final selectedElementKey = selectedElement.key;

    if (selectedElementKey == null && selectedElementKey is GlobalKey) return;

    final elementSize = (selectedElementKey as GlobalKey).currentContext?.size;

    _currentDraggedElementSize = elementSize;

    

    setState(() => isDragging = true);
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
        final updatedText = updatedTexts[widgetToUpdateIndex].copyWith(
          isSelected: true,
        );

        updatedTexts.removeAt(widgetToUpdateIndex);
        updatedTexts.add(updatedText);

        setState(() {
          isDragging = false;
          texts = updatedTexts;
        });

        if (updatedTexts.isTextSelected) {
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

  void _createDraggableText({
    double? top,
    double? left,
    required String title,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(SelectableDraggableWidget.text(
      key: GlobalKey(),
      title: title,
      id: uuid,
      onTap: () => selectUnselectWidget(id: uuid, isSelected: true),
      onTapOutside: (tapPosition) {
        final stackContext = _stackKey.currentContext;
        final stackSize = stackContext?.size;
        if (stackContext == null || stackSize == null) return;

        final bottomSectionContext = _bottomSectionKey.currentContext;
        final bottomSectionSize = bottomSectionContext?.size;
        if (bottomSectionContext == null || bottomSectionSize == null) return;

        final renderBox = stackContext.findRenderObject() as RenderBox;
        final offset = renderBox.localToGlobal(Offset.zero);

        final bottomSectionRenderBox = bottomSectionContext.findRenderObject() as RenderBox;
        final bottomSectionOffset = bottomSectionRenderBox.localToGlobal(Offset.zero);

        final isTapInsideStack = OffsetUtils.isTapPositionInElement(
          elementPosition: offset,
          elementSize: stackSize,
          tapPosition: tapPosition,
        );

        final isTapAboveBottomSection = OffsetUtils.isTapPositionInElement(
          elementPosition: bottomSectionOffset,
          elementSize: bottomSectionSize,
          tapPosition: tapPosition,
        );

        if (!isTapAboveBottomSection && isTapInsideStack) {
          selectUnselectWidget(id: uuid, isSelected: false);
        }
      },
      onDragStarted: () {
        onElementDragStarted(uuid: uuid);
      },
      onDragEnd: (details) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        _onDragEnd(details: details, uuid: uuid);
        // });
      },
      top: top ?? null,
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
    texts.add(SelectableDraggableWidget.icon(
      key: GlobalKey(),
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
      onDragStarted: () {
        onElementDragStarted(uuid: uuid);
      },
      onDragEnd: (details) {
        _onDragEnd(details: details, uuid: uuid);
      },
      top: top ?? 20,
      left: left ?? null,
      isSelected: isSelected,
      iconData: Icons.hardware,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          //
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              initExpandedHeight ??= constraints.maxHeight;
              return OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: double.infinity,
                minHeight: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096'),
                        fit: BoxFit.fitHeight),
                    color: Colors.grey[200],
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: initExpandedHeight!),
                    // height: initExpandedHeight,
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
              );
            }),
          ),
          Column(
            key: _bottomSectionKey,
            children: [
              Container(
                color: Colors.green,
                child: texts.isTextSelected
                    ? SafeArea(
                        child: Column(
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

                                  final updatedText = texts[selectedWidgetIndex].copyWith(
                                    title: Optional.of(text),
                                    key: Optional.of(GlobalKey()),
                                  );
                                  updatedTexts[selectedWidgetIndex] = updatedText;

                                  setState(() => texts = updatedTexts);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Your name',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      unselectedCurrentSelectedWidget();
                                    },
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
                            if (MediaQuery.of(context).viewInsets.bottom == 0) ...[
                              Container(
                                color: Colors.amber,
                                child: Column(
                                  children: [
                                    Wrap(
                                      children: [16, 32, 64]
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                changeTextStyle(fontSize: e.toDouble());

                                              },
                                              child: Text(e.toString())))
                                          .toList(),
                                    ),
                                    Wrap(
                                      children: [Colors.red, Colors.green, Colors.blue]
                                          .map((e) => TextButton(
                                              onPressed: () {
                                                changeTextStyle(fontColor: e);
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                color: e,
                                              )))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (MediaQuery.of(context).viewInsets.bottom == 0 && !texts.isTextSelected)
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        textEditingController.value = TextEditingValue(
                          text: '',
                          selection: TextSelection(baseOffset: 0, extentOffset: 0),
                        );
                        unselectedCurrentSelectedWidget(performSetState: false);
                        setState(() {
                          _createDraggableText(
                            isSelected: true,
                            title: '',
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Text',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
