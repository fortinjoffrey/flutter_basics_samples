import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Semantics(
                label: 'Main title',
                header: true,
                excludeSemantics: true,
                child: Text(
                  'This is a title',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              ExcludeSemantics(
                child: Text('Name'),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
              Semantics(
                textField: true,
                label: 'Name',
                excludeSemantics: true,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              Image.network('https://docs.flutter.dev/assets/images/dash/Dashatars.png'), // ignored by VoiceOver
              Image.network(
                'https://docs.flutter.dev/assets/images/dash/Dashatars.png',
                semanticLabel: 'Dash image',
              ), // not ignored by VoiceOver
              Semantics(
                label: 'This is a body text',
                excludeSemantics: true, // Exclude semantics of descendants
                child: Text('Body text'),
              ),
              Icon(Icons.read_more), // ignored by VoiceOver
              Icon(
                Icons.read_more,
                semanticLabel: 'Read more',
              ), // not ignored by VoiceOver
              // Reads second text before first
              Row(
                children: [
                  Semantics(
                    label: 'Text 2',
                    child: Column(
                      children: [
                        Text('Text 1'),
                        ExcludeSemantics(child: Text('Text 2')),
                      ],
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print('foo');
                },
                child: Text('Validate'),
              ),
              MergeSemantics(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'I am a',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('Text!', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
