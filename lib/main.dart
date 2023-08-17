import 'package:basics_samples/complete_example_using_matrix_gesture_detector/complete_example_using_matrix_gesture_detector.dart';
import 'package:basics_samples/examples/example_rotate_onPan.dart';
import 'package:basics_samples/examples/example_rotate_onScale.dart';
import 'package:basics_samples/examples/example_scale_onPan.dart';
import 'package:basics_samples/examples/example_scale_onScale.dart';
import 'package:basics_samples/examples/example_translate_onPan.dart';
import 'package:basics_samples/examples/example_rotate_and_scale.dart';
import 'package:basics_samples/examples/example_rotate_scale_translate.dart';
import 'package:flutter/material.dart';

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
        body: Center(
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
            ],
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
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(backgroundColor)),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => destinationPage,
        ));
      },
      child: Text(text),
    );
  }
}
