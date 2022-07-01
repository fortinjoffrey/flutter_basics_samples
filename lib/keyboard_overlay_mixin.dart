import 'package:basics_samples/keyboard_input_controls_wiget.dart';
import 'package:flutter/material.dart';

abstract class KeyboardOverlayManager {
  static OverlayEntry? _overlayEntry;

  static showOverlay(
    BuildContext context, {
    VoidCallback? onDonePressed,
    VoidCallback? onBackPressed,
    VoidCallback? onNextPressed,
  }) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);

    if (overlayState == null) {
      return;
    }

    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: KeyboardInputControlsWidget(
            onDonePressed: onDonePressed,
            onBackPressed: onBackPressed,
            onNextPressed: onNextPressed,
            controlsColor: Colors.black,
          ));
    });

    overlayState.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
