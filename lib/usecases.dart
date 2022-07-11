import 'package:basics_samples/move_focus_to_text_field_on_button_pressed.dart';
import 'package:basics_samples/move_focus_to_text_field_on_button_pressed_scroll.dart';
import 'package:flutter/widgets.dart';

class Usecase {
  final String title;
  final List<String> testConditions;
  final Widget? demoWidget;

  const Usecase({required this.title, required this.testConditions, this.demoWidget});
}

const List<Usecase> usecases = [
  const Usecase(
    title: 'Move the input focus to a text field when pressing a button',
    testConditions: [
      'The button and textfield are visible on screen',
      'There is not other elements on screen',
      'The input focus is not linked to the textfield',
    ],
    demoWidget: MoveFocusToTextFieldOnButtonPressed(),
  ),
  const Usecase(
    title: 'Move the input focus to a text field when pressing a button',
    testConditions: [
      'The button and textfield are visible on screen',
      'There is not other elements on screen',
      'The input focus is already linked to the textfield',
    ],
    demoWidget: MoveFocusToTextFieldOnButtonPressed(),
  ),
  const Usecase(
    title: 'Move the input focus to a text field when pressing a button',
    testConditions: [
      'The button and textfield are not visible on screen simultaneously',
      'There is not other elements on screen',
      'The input focus is not linked to the textfield',
    ],
    demoWidget: MoveFocusToTextFieldOnButtonPressedScroll(),
  ),
  const Usecase(
    title: 'Move the input focus to a text field when pressing a button',
    testConditions: [
      'The button and textfield are not visible on screen simultaneously',
      'There is a text between the textfield and button to help for scrolling when keyboard has appeared',
      'The input focus is already linked to the textfield'
    ],
    demoWidget: MoveFocusToTextFieldOnButtonPressedScroll(),
  ),
];
