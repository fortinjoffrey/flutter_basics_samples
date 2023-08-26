import 'package:basics_samples/components/draggable_text.dart';
import 'package:basics_samples/deconstruct_widgets/deconstruct_widgets_utils.dart';
import 'package:basics_samples/editor_screen/editor_utils.dart';
import 'package:basics_samples/reconstruct_widgets/models.dart';
import 'package:basics_samples/reconstruct_widgets/reconstruct_widgets_utils.dart';
import 'package:basics_samples/utils/offset_utils.dart';
import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:uuid/uuid.dart';
import 'package:collection/collection.dart';

// class EditorScreenWithImportedInfo extends StatelessWidget {
//   const EditorScreenWithImportedInfo({super.key, required this.json});

//   final Map<String, dynamic> json;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ReconstructWidgetCubit>(
//       create: (context) => ReconstructWidgetCubit(json)..init(),
//       child: EditorScreen(),
//     );
//   }
// }

class EditorScreen extends StatefulWidget {
  EditorScreen({
    Key? key,
    required this.importInformation,
  }) : super(key: key);

  final PositionInformation importInformation;

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  List<SelectableDraggableWidget> texts = [];
  bool isDragging = false;
  final _stackKey = GlobalKey();
  final textEditingController = TextEditingController();
  double? initExpandedHeight;
  double? initExpandedWidth;
  final _bottomSectionKey = GlobalKey();
  Size? _currentDraggedElementSize;
  Offset? _lastSelectedElementPosition;
  static const double _initialTopPosition = 150;
  final _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Why is this done in the next frame
    // We need to have the true max height and width available to position our elements
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.importInformation.textInformations.isNotEmpty) {
        for (final TextInformation info in widget.importInformation.textInformations) {
          final widgetPosition = getOffsetFromTextInformation(
            textInformation: info,
            containerHeight: initExpandedHeight!,
            containerWidth: initExpandedWidth!,
          );

          _createDraggableText(
            top: widgetPosition.dy,
            left: widgetPosition.dx,
            title: info.text,
            fontSize: info.fontSize,
            color: info.color,
          );
          // _createDraggableText(
          //   top: 138.5,
          //   left: 23,
          //   title: info.text,
          //   fontSize: info.fontSize,
          //   color: info.color,
          // );
        }
        setState(() {});

        // créer la liste des texts à partir
      }
      // _createDraggableText(top: 200, title: 'Drag 1');
      // _createDraggableText(top: 100, title: 'Drag 2');
      // _createDraggableText(top: 50, title: 'Drag 3');
    });

    // _createDraggableIcon(top: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Editor Screen'),
        actions: [
          if (!texts.hasWidgetSelected)
            ElevatedButton(
              onPressed: () {
                final widgetInfos = texts.map((e) => WidgetInfoForExport.fromSelectableDraggableWidget(e)).toList();

                final Map<String, dynamic> r = exportWidgetsInformation(
                  containerKey: _stackKey,
                  //TODO: balancer les vraies info du container ici
                  containerAspectRatio: widget.importInformation.containerInformation.aspectRatio,
                  containerWidthProportion: widget.importInformation.containerInformation.widthProportion,
                  widgetInfos: widgetInfos,
                );

                print(r);

                final i = PositionInformation.fromMap(r);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return EditorScreen(importInformation: i);
                    },
                  ),
                );

                print(i);
              },
              child: const Text('Export'),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              double width =
                  MediaQuery.of(context).size.width * widget.importInformation.containerInformation.widthProportion;

              double height = width / widget.importInformation.containerInformation.aspectRatio;

              if (height > constraints.maxHeight) {
                height = constraints.maxHeight;
                width = height * widget.importInformation.containerInformation.aspectRatio;
              }

              initExpandedHeight ??= height;
              initExpandedWidth ??= width;

              return OverflowBox(
                alignment: Alignment.topCenter,
                maxHeight: initExpandedHeight,
                maxWidth: initExpandedWidth,
                minHeight: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('https://pbs.twimg.com/media/FKNlhKZUcAEd7FY?format=jpg&name=4096x4096'),
                        fit: BoxFit.fitHeight),
                    color: Colors.grey[200],
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: initExpandedHeight!,
                      maxWidth: initExpandedWidth!,
                    ),
                    child: Stack(
                      key: _stackKey,
                      alignment: Alignment.center,
                      children: <Widget>[
                        ...getChildrenWithOpacity(texts),
                        if (isDragging)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DragTarget<String>(
                                onWillAccept: (id) {
                                  // Faire un retour haptic ici
                                  return texts.firstWhereOrNull((widget) => widget.id == id) != null;
                                },
                                onAccept: (id) {
                                  setState(() => texts.removeWhere((element) => element.id == id));
                                },
                                onLeave: (data) {
                                  print('onLeave');
                                },
                                builder: (context, candidates, rejects) {
                                  final hasCandidates = candidates.isNotEmpty;

                                  return CircleAvatar(
                                    backgroundColor: hasCandidates ? Colors.red : Colors.white,
                                    radius: hasCandidates ? 25 : 20,
                                    child: Icon(Icons.delete, color: hasCandidates ? Colors.white : Colors.black),
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
                child: texts.isTextSelected && !isDragging
                    ? SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                focusNode: _textFieldFocusNode,
                                controller: textEditingController,
                                maxLines: 1,
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
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
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
                                      children: [8, 16, 32, 64, 128]
                                          .map((e) => TextButton(
                                              onPressed: () => changeTextStyle(fontSize: e.toDouble()),
                                              child: Text(e.toString())))
                                          .toList(),
                                    ),
                                    Wrap(
                                      children: [Colors.red, Colors.green, Colors.blue, Colors.white, Colors.black]
                                          .map((e) => TextButton(
                                              onPressed: () => changeTextStyle(fontColor: e),
                                              child: Container(height: 20, width: 20, color: e)))
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
                  // height: 350,
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
                            top: _initialTopPosition,
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
      setState(() => texts = updatedTexts);
    }
  }

  bool isElementInStack({
    required Offset elementOffset,
    required Size elementSize,
  }) {
    final stackOffset = getOffsetFromKey(_stackKey);
    final stackSize = getSizeFromKey(_stackKey);

    if (stackOffset == null || stackSize == null) return false;

    return OffsetUtils.isElementHasAtLeastOnePointInsideParent(
      parentOffset: stackOffset,
      parentSize: stackSize,
      childOffset: elementOffset,
      childSize: elementSize,
    );
  }

  void unselectedCurrentSelectedWidget({bool performSetState = true}) {
    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((widget) => widget.isSelected);
    if (selectedWidgetIndex != -1) {
      final SelectableDraggableWidget selectedWidget = updatedTexts[selectedWidgetIndex];

      if (selectedWidget.isText && selectedWidget.title?.isEmpty == true) {
        updatedTexts.removeAt(selectedWidgetIndex);
      } else {
        if (_lastSelectedElementPosition == null) {
          updatedTexts[selectedWidgetIndex] = selectedWidget.copyWith(
            isSelected: false,
          );
        } else {
          updatedTexts[selectedWidgetIndex] = selectedWidget.copyWith(
            isSelected: false,
            top: _lastSelectedElementPosition != null ? Optional.fromNullable(_lastSelectedElementPosition?.dy) : null,
            left: _lastSelectedElementPosition != null ? Optional.fromNullable(_lastSelectedElementPosition?.dx) : null,
          );
          _lastSelectedElementPosition = null;
        }
      }
    }
    if (performSetState) setState(() => texts = updatedTexts);
  }

  void _onDragEnd({
    required DraggableDetails details,
    required String uuid,
  }) {
    final selectedElement = texts.firstWhereOrNull((element) => element.id == uuid);

    if (selectedElement == null) {
      _currentDraggedElementSize = null;
      if (isDragging) {
        setState(() => isDragging = false);
      }
      return;
    }

    final selectedElementSize = _currentDraggedElementSize;

    if (selectedElementSize == null) return;

    final stackContext = _stackKey.currentContext;
    final stackSize = stackContext?.size;
    if (stackContext == null || stackSize == null) return;

    final stackRenderBox = stackContext.findRenderObject() as RenderBox;
    final stackOffset = stackRenderBox.localToGlobal(Offset.zero);

    final bottomSectionContext = _bottomSectionKey.currentContext;
    final bottomSectionSize = bottomSectionContext?.size;
    if (bottomSectionContext == null || bottomSectionSize == null) return;

    final updatedTexts = texts;
    final selectedWidgetIndex = texts.indexWhere((element) => element.id == uuid);

    if (selectedWidgetIndex == -1) return;

    final isElementDraggedInStack = OffsetUtils.isElementHasAtLeastOnePointInsideParent(
      parentOffset: stackOffset,
      parentSize: stackSize,
      childOffset: details.offset,
      childSize: selectedElementSize,
    );

    if (isElementDraggedInStack) {
      // if (!isElementDraggedInBottomSection && isElementDraggedInStack) {
      final updatedText = texts[selectedWidgetIndex].copyWith(
        top: Optional.fromNullable(details.offset.dy - stackOffset.dy),
        left: Optional.fromNullable(details.offset.dx - stackOffset.dx),
      );
      updatedTexts.removeAt(selectedWidgetIndex);
      updatedTexts.add(updatedText);

      setState(() {
        isDragging = false;
        texts = updatedTexts;
      });
    } else {
      setState(() => isDragging = false);
    }
  }

  void onElementDragStarted({
    required String uuid,
  }) {
    FocusScope.of(context).unfocus();
    final selectedElement = texts.firstWhereOrNull((element) => element.id == uuid);

    if (selectedElement == null) return;

    final selectedElementKey = selectedElement.key;

    if (selectedElementKey == null || !(selectedElementKey is GlobalKey)) return;

    final elementSize = selectedElementKey.currentContext?.size;

    _currentDraggedElementSize = elementSize;
    unselectedCurrentSelectedWidget(performSetState: false);

    var updatedTexts = texts;
    final widgetToUpdateIndex = updatedTexts.indexWhere((widget) => widget.id == uuid);
    if (widgetToUpdateIndex != -1) {
      final selectedElementKey = updatedTexts[widgetToUpdateIndex].key;

      if (selectedElementKey == null || !(selectedElementKey is GlobalKey)) return;

      final elementSize = getSizeFromKey(selectedElementKey);

      if (elementSize == null) return;

      final updatedText = updatedTexts[widgetToUpdateIndex].copyWith(
        isDragged: true,
      );

      updatedTexts.removeAt(widgetToUpdateIndex);
      updatedTexts.add(updatedText);

      setState(() {
        texts = updatedTexts;
        isDragging = true;
      });
    }
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
        final selectedElementKey = updatedTexts[widgetToUpdateIndex].key;

        if (selectedElementKey == null || !(selectedElementKey is GlobalKey)) return;

        final elementSize = getSizeFromKey(selectedElementKey);
        final stackSize = getSizeFromKey(_stackKey);

        if (elementSize == null || stackSize == null) return;

        // avant de déplacer garder en mémoire la dernière position du widget
        _lastSelectedElementPosition = getLocalOffsetFromParent(selectedElementKey, _stackKey);

        final updatedText = updatedTexts[widgetToUpdateIndex].copyWith(
          isSelected: true,
          top: Optional.fromNullable(_initialTopPosition),
          left: Optional.fromNullable((stackSize.width / 2) - (elementSize.width / 2)),
        );

        if (updatedText.isText) {
          _fillTextFieldWithTitle(updatedText);
        }

        updatedTexts.removeAt(widgetToUpdateIndex);
        updatedTexts.add(updatedText);

        setState(() => texts = updatedTexts);
      }
    }

    setState(() => texts = updatedTexts);
  }

  void _fillTextFieldWithTitle(SelectableDraggableWidget element) {
    final title = element.title;
    if (title != null) {
      textEditingController.value = TextEditingValue(
        text: element.title ?? '',
        selection: TextSelection(baseOffset: title.length, extentOffset: title.length),
      );
    }
  }

  void _createDraggableText({
    double? top,
    double? left,
    required String title,
    double? fontSize,
    Color? color,
    bool isSelected = false,
  }) {
    final String uuid = Uuid().v1();
    texts.add(SelectableDraggableWidget.text(
      key: GlobalKey(),
      title: title,
      fontSize: fontSize,
      color: color,
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
        _onDragEnd(details: details, uuid: uuid);
      },
      top: top,
      left: left,
      isSelected: isSelected,
      maxWidth: initExpandedWidth ?? MediaQuery.of(context).size.width,
    ));
  }

  // ignore: unused_element
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
      maxWidth: initExpandedWidth ?? MediaQuery.of(context).size.width,
    ));
  }
}

List<Widget> getChildrenWithOpacity(List<SelectableDraggableWidget> texts) {
  return [
    if (texts.length > 1) ...texts.getRange(0, texts.length - 1),
    Positioned.fill(
      child: IgnorePointer(
        ignoring: !texts.hasWidgetSelected,
        child: AnimatedOpacity(
          opacity: texts.hasWidgetSelected ? .4 : 0,
          duration: const Duration(seconds: 1),
          child: Container(color: Colors.black),
        ),
      ),
    ),
    if (texts.length >= 1) texts.last,
  ];
}
