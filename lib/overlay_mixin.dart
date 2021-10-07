import 'package:flutter/material.dart';

mixin OverlayMixin<T extends StatefulWidget> on State<T> {
  @protected
  List<OverlayEntry> get overlayEntries;

  late List<OverlayEntry> _overlayEntries;

  @override
  void initState() {
    super.initState();
    _overlayEntries = overlayEntries;
  }

  /// Hide the provided [OverlayEntry]
  ///
  /// If [OverlayEntry] is omitted, by default the first overlay entry of the [overlayEntries] list is hidden
  void hideOverlay([OverlayEntry? overlayEntry]) {
    assert(_overlayEntries.isNotEmpty && (overlayEntry == null || _overlayEntries.contains(overlayEntry)));

    overlayEntry == null ? overlayEntries[0].remove() : overlayEntry.remove();
  }

  /// Show the provided [OverlayEntry]
  ///
  /// If [OverlayEntry] is omitted, by default the first overlay entry of the [overlayEntries] list is shown
  void showOverlay([OverlayEntry? overlayEntry]) {
    assert(_overlayEntries.isNotEmpty && (overlayEntry == null || _overlayEntries.contains(overlayEntry)));

    final overlayState = Overlay.of(context);
    overlayState?.insert(overlayEntry ?? _overlayEntries[0]);
  }
}
