import 'package:basics_samples/editor_screen/editor_screen.dart';
import 'package:basics_samples/reconstruct_widgets/models.dart';
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
      home: EditorScreen(
        importInformation: PositionInformation(
          textInformations: [
            TextInformation(
              text: 'Mollit Lorem in labore enim sunt occaecat ea labore reprehenderit ut deserunt proident ad ut.',
              fontSize: 24,
              proportion: OffsetProportion(x: .5, y: .5),
              color: Colors.white,
            ),
            TextInformation(
              text: 'Texte 2',
              fontSize: 48,
              proportion: OffsetProportion(x: .2, y: .2),
              color: Colors.blue,
            ),
            TextInformation(
              text: 'Texte 3',
              fontSize: 48,
              proportion: OffsetProportion(x: .8, y: .8),
              color: Colors.red,
            ),
          ],
          containerInformation: ContainerInformation(
            aspectRatio: 1 / 1.3,
            widthProportion: 1,
          ),
        ),
      ),
    );
  }
}
