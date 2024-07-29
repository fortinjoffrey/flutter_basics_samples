import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_detection/keyboard_detection.dart';

class ListViewPageUsingDetection extends StatefulWidget {
  const ListViewPageUsingDetection({super.key});

  @override
  State<ListViewPageUsingDetection> createState() => _ListViewPageUsingDetectionState();
}

class _ListViewPageUsingDetectionState extends State<ListViewPageUsingDetection> with WidgetsBindingObserver {
  final scrollController = ScrollController();
  double _currentPosition = 0.0;
  late double lastBottomInset = MediaQuery.of(context).viewInsets.bottom;
  late double maxBottomInset = MediaQuery.of(context).viewInsets.bottom;
  late double currentSafeAreaHeight = MediaQuery.of(context).padding.bottom;
  bool lastAppearing = false;
  late StreamSubscription<bool> keyboardSubscription;
  KeyboardState lastKeyboardState = KeyboardState.unknown;
  bool userHasScrolledWithKeyboardVisible = false;

  late KeyboardDetectionController keyboardDetectionController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    keyboardDetectionController = KeyboardDetectionController(
      onChanged: (value) {
        print('Keyboard visibility onChanged: $value');
        print('Keyboard visibility lastKeyboardState: $lastKeyboardState');
        print('Keyboard visibility keyboardState: $value');
        if (lastKeyboardState == KeyboardState.visible && value == KeyboardState.hiding) {
          print('Keyboard visibility _currentPosition before: $_currentPosition');
          print('Keyboard visibility maxBottomInset: $maxBottomInset');
          print('Keyboard visibility userHasScrolledWithKeyboardVisible: $userHasScrolledWithKeyboardVisible');

          // _currentPosition = _currentPosition - maxBottomInset;
          if (userHasScrolledWithKeyboardVisible) {
            userHasScrolledWithKeyboardVisible = false;
            _currentPosition = _currentPosition - maxBottomInset + 34;
            maxBottomInset = 0;
            print('Keyboard visibility userHasScrolledWithKeyboardVisible after: $userHasScrolledWithKeyboardVisible');
          }
          print('Keyboard visibility _currentPosition after: $_currentPosition');
          // maxBottomInset = 0;
        }
        lastKeyboardState = value;
      },
    );

    scrollController.addListener(() {
      // _currentPosition = scrollController.offset;
      // print('currentPosition: $_currentPosition');
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    print('target appearing: bottomInset: $bottomInset');
    maxBottomInset = maxBottomInset < bottomInset ? bottomInset : maxBottomInset;
    final currentAppearing = lastBottomInset == bottomInset ? null : lastBottomInset < bottomInset;
    print('target appearing: lastBottomInset: $lastBottomInset');

    final keyboardHasDissaapeared = lastBottomInset > 0 && bottomInset == 0;
    print('target appearing: keyboardHasDissaapeared: $keyboardHasDissaapeared');

    lastBottomInset = bottomInset;
    print('target current appearing: $currentAppearing');
    lastAppearing = currentAppearing ?? lastAppearing;
    print('target last appearing: $lastAppearing');
    print('target Bottom inset: $bottomInset');
    final safeAreaHeight = MediaQuery.of(context).viewPadding.bottom;
    print('target Safe area height: $safeAreaHeight');
    // final targetBefore = _currentPosition + bottomInset + (!appearing ? 0 : -currentSafeAreaHeight);
    // final targetBefore = _currentPosition + bottomInset + (!appearing ? currentSafeAreaHeight : -currentSafeAreaHeight);
    // final targetBefore = _currentPosition + bottomInset - ( bottomInset == 336 ? 34 : 0);
    // print('targetBefore: $targetBefore');
    var targetBefore = _currentPosition + bottomInset + (lastAppearing == true ? -34 : 0);
    if (keyboardHasDissaapeared) {
      //   _currentPosition = _currentPosition - maxBottomInset;
      print('maxBottomInset will reset: $maxBottomInset');
      targetBefore = _currentPosition + bottomInset - 34;
      // maxBottomInset = 0;
    }

    // print('targetAfter: $target');
    // print('target: $target');
    scrollController.jumpTo(targetBefore);
    // if (lastBottomInset > 0 && bottomInset == 0) {
    //   _currentPosition = 0;
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    final items = List<String>.generate(200, (i) => "Item $i");

    return KeyboardDetection(
      controller: keyboardDetectionController,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('ListView with TextField'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            print('FAB: Bottom inset: $bottomInset');
            // for (int i = 0; i < 1000; i++) {
            //   await Future<void>.delayed(const Duration(milliseconds: 30));
            //   scrollController.jumpTo(i + 1);
            // }
          },
          child: const Icon(Icons.arrow_downward),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is UserScrollNotification) {
                        print('UserScrollNotification');
                        setState(() {
                          // _currentPosition = scrollController.offset + MediaQuery.of(context).viewInsets.bottom;
                          _currentPosition = scrollController.offset;
                          if (MediaQuery.of(context).viewInsets.bottom > 0) {
                            userHasScrolledWithKeyboardVisible = true;
                          }

                          print('currentPosition: $_currentPosition');
                        });
                      }
                      return false;
                    },
                    child: ListView.separated(
                      // reverse: true,
                      controller: scrollController,
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        height: 2,
                      ),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(
                            children: [
                              Text(items[index]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text('Scroll Position: $_currentPosition'),
                Padding(
                  padding: const EdgeInsets.only(
                      // horizontal: 8.0,
                      // bottom: currentSafeAreaHeight, // bottom: MediaQuery.of(context).padding.bottom
                      ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your text here',
                    ),
                    onSubmitted: (text) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
