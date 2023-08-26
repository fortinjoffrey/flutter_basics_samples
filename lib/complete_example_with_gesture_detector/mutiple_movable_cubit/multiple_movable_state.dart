import 'package:flutter/material.dart';

class MovablePositionedState {
  final GlobalKey key;
  final double top;
  final double? left;
  final double rotation;
  final double previousRotation;
  final double scale;
  final double previousScale;
  final bool animates;
  final bool selected;

  const MovablePositionedState({
    required this.key,
    required this.top,
    required this.left,
    required this.rotation,
    required this.previousRotation,
    required this.scale,
    required this.previousScale,
    required this.animates,
    required this.selected,
  });

  MovablePositionedState copyWith({
    GlobalKey? key,
    double? top,
    // Optional<double?>? left,
    double? left,
    double? rotation,
    double? previousRotation,
    double? scale,
    double? previousScale,
    bool? animates,
    bool? selected,
  }) {
    return MovablePositionedState(
      key: key ?? this.key,
      top: top ?? this.top,
      left: left ?? this.left,
      rotation: rotation ?? this.rotation,
      previousRotation: previousRotation ?? this.previousRotation,
      scale: scale ?? this.scale,
      previousScale: previousScale ?? this.previousScale,
      animates: animates ?? this.animates,
      selected: selected ?? this.selected,
    );
  }

  @override
  String toString() {
    return 'MovablePositionedState(key: $key, top: $top, left: $left, rotation: $rotation, previousRotation: $previousRotation, scale: $scale, previousScale: $previousScale, animates: $animates, selected: $selected)';
  }
}

class MultipleMovableState {
  final List<MovablePositionedState> movablePositionedStates;

  const MultipleMovableState({required this.movablePositionedStates});

  MultipleMovableState copyWith({
    List<MovablePositionedState>? movablePositionedStates,
  }) {
    return MultipleMovableState(
      movablePositionedStates: movablePositionedStates ?? this.movablePositionedStates,
    );
  }
}
