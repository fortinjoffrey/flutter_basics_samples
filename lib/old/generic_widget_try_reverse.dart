import 'package:flutter/material.dart';
import 'package:keyboard_detection/keyboard_detection.dart';

class GenericWidgetTryReverse extends StatefulWidget {
  const GenericWidgetTryReverse({
    super.key,
    required this.scrollController,
    required this.child,
  });

  final ScrollController scrollController;
  final Widget child;

  @override
  State<GenericWidgetTryReverse> createState() => _GenericWidgetTryReverseState();
}

class _GenericWidgetTryReverseState extends State<GenericWidgetTryReverse> with WidgetsBindingObserver {
  double _currentPosition = 0.0;
  late double _lastBottomInset = MediaQuery.of(context).viewInsets.bottom;
  late double _maxBottomInset = MediaQuery.of(context).viewInsets.bottom;
  bool _lastAppearing = false;
  KeyboardState _lastKeyboardState = KeyboardState.unknown;
  bool _userHasScrolledWithKeyboardVisible = false;
  late KeyboardDetectionController keyboardDetectionController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    keyboardDetectionController = KeyboardDetectionController(
      onChanged: (value) {
        if (_lastKeyboardState == KeyboardState.visible && value == KeyboardState.hiding) {
          if (_userHasScrolledWithKeyboardVisible) {
            _userHasScrolledWithKeyboardVisible = false;
            final safeAreaHeight = MediaQuery.of(context).viewPadding.bottom;
            _currentPosition = _currentPosition - _maxBottomInset + safeAreaHeight;
            _maxBottomInset = 0;
          }
        }
        _lastKeyboardState = value;
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    print('target appearing: bottomInset: $bottomInset');
    _maxBottomInset = _maxBottomInset < bottomInset ? bottomInset : _maxBottomInset;
    final currentAppearing = _lastBottomInset == bottomInset ? null : _lastBottomInset < bottomInset;
    print('current appearing: $currentAppearing');

    final isKeyboardGone = _lastBottomInset > 0 && bottomInset == 0;
    print('keyboardHasDissaapeared: $isKeyboardGone');

    _lastBottomInset = bottomInset;
    _lastAppearing = currentAppearing ?? _lastAppearing;

    final safeAreaHeight = MediaQuery.of(context).viewPadding.bottom;
    double targetBefore = _currentPosition + bottomInset + (_lastAppearing == true ? -safeAreaHeight : 0);

    if (isKeyboardGone) {
      targetBefore = _currentPosition + bottomInset - safeAreaHeight;
    }
    print('targetBefore: $targetBefore');

    widget.scrollController.jumpTo(targetBefore);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDetection(
      controller: keyboardDetectionController,
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is UserScrollNotification) {
            _currentPosition = widget.scrollController.offset;
            print('currentPosition: $_currentPosition');
            if (MediaQuery.of(context).viewInsets.bottom > 0) {
              _userHasScrolledWithKeyboardVisible = true;
            }
          }
          return false;
        },
        child: widget.child,
      ),
    );
  }
}
