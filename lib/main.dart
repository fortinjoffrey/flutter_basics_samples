import 'package:basics_samples/complete_example_using_matrix_gesture_detector/complete_example_using_matrix_gesture_detector.dart';
import 'package:basics_samples/examples/example_rotate_onPan.dart';
import 'package:basics_samples/examples/example_rotate_onScale.dart';
import 'package:basics_samples/examples/example_scale_onPan.dart';
import 'package:basics_samples/examples/example_scale_onScale.dart';
import 'package:basics_samples/examples/example_translate_onPan.dart';
import 'package:basics_samples/examples/example_rotate_and_scale.dart';
import 'package:basics_samples/examples/example_rotate_scale_translate.dart';
import 'package:basics_samples/examples_with_position/change_position_onPan_stateless_rotate_scale_stateful.dart';
import 'package:basics_samples/examples_with_position/change_position_onPan_with_component_stateful.dart';
import 'package:basics_samples/examples_with_position/change_position_onPan_with_component_stateless.dart';
import 'package:flutter/material.dart';

import 'examples_with_position/change_position_onPan_rotate_scale_with_component_stateful .dart';
import 'examples_with_position/complete_example_change_position_onPan_rotate_scale_stateful.dart';
import 'examples_with_position/complete_example_change_position_onPan_with_component_stateful.dart';

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
      home: HomePage(),
      // home: ZoomPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transform examples'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(thickness: 10),
                Text(
                  'Using GestureDectector',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Divider(),
                _NavigationButton(
                  backgroundColor: Colors.red,
                  destinationPage: ExampleRotateOnPan(),
                  text: 'Rotate onPan',
                ),
                _NavigationButton(
                  backgroundColor: Colors.orange,
                  destinationPage: ExampleRotateOnScale(),
                  text: 'Rotate onScale',
                ),
                _NavigationButton(
                  backgroundColor: Colors.blue,
                  destinationPage: ExampleScaleOnPan(),
                  text: 'Scale onPan',
                ),
                _NavigationButton(
                  backgroundColor: Colors.purple,
                  destinationPage: ExampleScaleOnScale(),
                  text: 'Scale onScale',
                ),
                _NavigationButton(
                  backgroundColor: Colors.green,
                  destinationPage: ExampleTranslateOnPan(),
                  text: 'Translate onPan',
                ),
                _NavigationButton(
                  backgroundColor: Colors.indigo,
                  destinationPage: ExampleRotateAndScale(),
                  text: 'Rotate and Scale',
                ),
                _NavigationButton(
                  backgroundColor: Colors.pink,
                  destinationPage: ExampleRotateScaleTranslate(),
                  text: 'Rotate, scale, translate',
                ),
                Divider(thickness: 10),
                Text(
                  'Using MatrixGestureDectector',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _NavigationButton(
                  backgroundColor: Colors.grey,
                  destinationPage: CompleteExampleUsingMatrixGestureDetector(),
                  text: 'Rotate, scale, translate',
                ),
                Divider(thickness: 10),
                Text(
                  'Using Positioned',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                _NavigationButton(
                  backgroundColor: Colors.pink,
                  destinationPage: ChangePositionOnPanWithComponentStateful(),
                  text: 'Change position onPan component stateful',
                ),
                _NavigationButton(
                  backgroundColor: Colors.green,
                  destinationPage: ChangePositionOnPanWithComponentStateless(),
                  text: 'Change position onPan component stateless',
                ),
                _NavigationButton(
                  backgroundColor: Colors.blue,
                  destinationPage: ChangePositionOnPanRotateScaleWithComponentStateful(),
                  text: 'Change position onPan Rotate Scale component stateful',
                ),
                _NavigationButton(
                  backgroundColor: Colors.purpleAccent,
                  destinationPage: ChangePositionOnPanStatelessRotateScaleStateful(),
                  text: 'Change position onPan Stateless Rotate Scale Stateful',
                ),
                _NavigationButton(
                  backgroundColor: Colors.black,
                  destinationPage: CompleteChangePositionOnPanStateful(),
                  text: 'Complete Change position onPan ',
                ),
                _NavigationButton(
                  backgroundColor: Colors.red,
                  destinationPage: CompleteChangePositionOnPanRotateScaleStateful(),
                  text: 'Complete Change position onPan rotation scale',
                ),
              ],
            ),
          ),
        ));
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.destinationPage,
    required this.backgroundColor,
    required this.text,
  });

  final Widget destinationPage;
  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 250),
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => destinationPage,
          ));
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
