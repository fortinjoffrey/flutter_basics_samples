import 'package:flutter/material.dart';
import 'package:keyboard_detection/keyboard_detection.dart';

/// !!! This does not supported reversed: true for now !!!
class AutoScrollWidget extends StatefulWidget {
  const AutoScrollWidget({
    super.key,
    required this.scrollController,
    required this.child,
  });

  final ScrollController scrollController;
  final Widget child;

  @override
  State<AutoScrollWidget> createState() => _AutoScrollWidgetState();
}

class _AutoScrollWidgetState extends State<AutoScrollWidget> with WidgetsBindingObserver {
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
            print('safeAreaHeight: $safeAreaHeight');
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
    _maxBottomInset = _maxBottomInset < bottomInset ? bottomInset : _maxBottomInset;
    final currentAppearing = _lastBottomInset == bottomInset ? null : _lastBottomInset < bottomInset;

    final isKeyboardGone = _lastBottomInset > 0 && bottomInset == 0;

    _lastBottomInset = bottomInset;
    _lastAppearing = currentAppearing ?? _lastAppearing;

    final safeAreaHeight = MediaQuery.of(context).viewPadding.bottom;
    double targetBefore = _currentPosition + bottomInset + (_lastAppearing == true ? -safeAreaHeight : 0);

    if (isKeyboardGone) {
      targetBefore = _currentPosition + bottomInset - safeAreaHeight;
    }

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
