import 'package:basics_samples/complete_example_with_gesture_detector/mutiple_movable_cubit/multiple_movable_state.dart';
import 'package:basics_samples/utils/offset_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class MultipleMovableCubit extends Cubit<MultipleMovableState> {
  MultipleMovableCubit()
      : super(
          MultipleMovableState(movablePositionedStates: []),
        );

  static const double defaultTop = 100;
  static const double defaultRotation = 0;
  static const double defaultScale = 1;

  void createMovablePositioned() {
    final movablePositionedStates = state.movablePositionedStates;
    final newMovablePositionedStates = [
      ...movablePositionedStates,
      MovablePositionedState(
        key: GlobalKey(),
        top: defaultTop,
        left: null,
        rotation: defaultRotation,
        previousRotation: defaultRotation,
        scale: defaultScale,
        previousScale: defaultScale,
        animates: false,
        selected: false,
      ),
    ];
    emit(MultipleMovableState(movablePositionedStates: newMovablePositionedStates));
  }

  void onScaleStart(GlobalKey key) {
    final movablePositionedStates = state.movablePositionedStates;

    final index = movablePositionedStates.indexWhere((element) => element.key == key);

    if (index == -1) return;

    final movableState = movablePositionedStates[index];

    final updatedMovableState = movableState.copyWith(
      previousRotation: movableState.rotation,
      previousScale: movableState.scale,
    );

    movablePositionedStates[index] = updatedMovableState;

    emit(
      MultipleMovableState(
        movablePositionedStates: movablePositionedStates,
      ),
    );
  }

  void onUpdate({
    required GlobalKey key,
    required double scale,
    required double rotation,
    required double top,
    required double left,
  }) {
    final movablePositionedStates = state.movablePositionedStates;

    final index = movablePositionedStates.indexWhere((element) => element.key == key);

    if (index == -1) return;
    final movableState = movablePositionedStates[index];

    final updatedMovableState = movableState.copyWith(
      rotation: rotation,
      scale: scale,
      top: top,
      left: left,
    );

    movablePositionedStates[index] = updatedMovableState;

    emit(MultipleMovableState(movablePositionedStates: movablePositionedStates));
  }

  List<MovablePositionedState> unselectedCurrentSelectedWidget() {
    final movablePositionedStates = state.movablePositionedStates;

    final index = movablePositionedStates.indexWhere((element) => element.selected == true);

    if (index == -1) return movablePositionedStates;

    final movableState = movablePositionedStates[index];

    final updatedMovableState = movableState.copyWith(
      selected: false,
    );

    movablePositionedStates[index] = updatedMovableState;

    return movablePositionedStates;
  }

  void onTap({required GlobalKey key, required GlobalKey stackKey}) {
    final movablePositionedStates = unselectedCurrentSelectedWidget();

    final index = movablePositionedStates.indexWhere((element) => element.key == key);

    if (index == -1) return;

    final stackSize = getSizeFromKey(stackKey);
    final widgetSize = getSizeFromKey(key);

    if (stackSize == null || widgetSize == null) return;

    final movableState = movablePositionedStates[index];

    final updatedMovableState = movableState.copyWith(
      selected: true,
      top: defaultTop,
      left: (stackSize.width / 2) - (widgetSize.width / 2),
      animates: true,
    );

    movablePositionedStates[index] = updatedMovableState;

    emit(MultipleMovableState(movablePositionedStates: movablePositionedStates));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _disableAnimationForMovable(key);
    });
  }

  void _disableAnimationForMovable(GlobalKey key) {
    final movablePositionedStates = state.movablePositionedStates;

    final index = movablePositionedStates.indexWhere((element) => element.key == key);

    if (index == -1) return;

    final movableState = movablePositionedStates[index];

    final updatedMovableState = movableState.copyWith(
      animates: false,
    );

    movablePositionedStates[index] = updatedMovableState;

    emit(MultipleMovableState(movablePositionedStates: movablePositionedStates));
  }

  void onTapOutside({
    required Offset tapPosition,
    required GlobalKey stackKey,
    required GlobalKey bottomSectionKey,
  }) {
    final stackOffset = getGlobalOffset(key: stackKey);
    final stackSize = getSizeFromKey(stackKey);

    final bottomSectionOffset = getGlobalOffset(key: bottomSectionKey);
    final bottomSectionSize = getSizeFromKey(bottomSectionKey);

    if (stackOffset == null || stackSize == null || bottomSectionOffset == null || bottomSectionSize == null) {
      return;
    }

    final tappedOnStack = isOffsetOnElement(
      offset: tapPosition,
      elementSize: stackSize,
      elementPosition: stackOffset,
    );

    final tappedOnBottomSection = isOffsetOnElement(
      offset: tapPosition,
      elementSize: bottomSectionSize,
      elementPosition: bottomSectionOffset,
    );

    if (!tappedOnBottomSection && tappedOnStack) {
      final movablePositionedStates = unselectedCurrentSelectedWidget();
      emit(MultipleMovableState(movablePositionedStates: movablePositionedStates));
    }
  }
}
