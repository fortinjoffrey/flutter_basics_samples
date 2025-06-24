import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/toto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _firstListController = ScrollController();
  final ScrollController _secondListController = ScrollController();

  @override
  void initState() {
    super.initState();
    _firstListController.addListener(_onFirstListScroll);
  }

  void _onFirstListScroll() {
    if (_firstListController.position.pixels >= _firstListController.position.maxScrollExtent) {
      // Quand on atteint la fin de la première liste, on commence à scroller la deuxième
      // _secondListController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _firstListController.dispose();
    _secondListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: RawGestureDetector(
        gestures: {
          VerticalDragGestureRecognizer: GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(),
            (VerticalDragGestureRecognizer instance) {
              instance
                ..onUpdate = (DragUpdateDetails details) {
                  // Ici vous avez accès à details.primaryDelta
                  print('Delta vertical: ${details.primaryDelta}');

                  // Vérifier si le texte a atteint sa fin de défilement
                  if (_firstListController.position.pixels >= _firstListController.position.maxScrollExtent) {
                    // Votre logique d'animation ici
                  }
                };
            },
          ),
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: SingleChildScrollView(
                child: Text(
                  '''Ex et nulla esse consectetur ut amet irure. Culpa deserunt Lorem ea aliqua consequat minim ipsum sunt velit. Esse enim tempor velit elit ad consequat consectetur cupidatat voluptate dolore sint officia. Ipsum sit Lorem anim culpa ex velit est.
                          
                          Commodo dolore sint enim adipisicing veniam. Velit pariatur qui irure nisi eu laboris commodo nostrud. Ipsum eu aliquip anim proident deserunt occaecat quis elit duis magna ea. Occaecat excepteur deserunt tempor id officia minim et. Laborum pariatur eiusmod sint culpa consectetur deserunt ipsum ut adipisicing. Occaecat eu excepteur nisi adipisicing proident esse amet et incididunt occaecat ea ex elit esse. Laboris adipisicing laboris non cupidatat id est consequat non eu id.
                          
                          Ut ipsum officia id exercitation proident Lorem magna commodo magna. Officia exercitation magna deserunt laboris elit culpa fugiat Lorem quis anim. Anim dolor cupidatat do laborum occaecat voluptate culpa cupidatat qui amet tempor irure. Sit consequat ullamco sint sunt deserunt enim esse magna. Tempor est duis velit irure adipisicing.
                          
                          Cupidatat consequat eu cillum sunt amet ut ullamco tempor nisi sint mollit labore velit. Esse anim eu et pariatur velit nulla Lorem est labore consectetur veniam laboris magna esse. Sunt reprehenderit reprehenderit eu voluptate non sint. Consequat excepteur eiusmod esse sit exercitation reprehenderit cupidatat laborum occaecat velit ea dolor exercitation. Aliquip nulla fugiat magna et laborum ex mollit commodo nisi deserunt do cupidatat. Dolor proident commodo dolore mollit dolor. Esse aute velit elit eiusmod id velit.
                          ''',
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                controller: _firstListController,
                physics: const NeverScrollableScrollPhysics(), // Désactive le scroll par défaut
                itemBuilder: (context, index) {
                  return Center(child: Text('Item $index'));
                },
                itemCount: 100,
              ),
            ),
            ...List.generate(
              30,
              (index) => Container(height: 100, color: Colors.primaries[index % Colors.primaries.length]),
            ),
          ],
        ),
      ),
    );
  }
}
