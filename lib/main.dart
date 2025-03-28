// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/content_responsive_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  static const _shortResponses = [
    'Excepteur quis nostrud cupidatat est reprehenderit elit ut non nisi laboris fugiat.',
    'Cupidatat ipsum cupidatat nulla anim eu labore aliqua culpa id.',
    'Excepteur adipisicing anim duis incididunt dolor excepteur proident nisi adipisicing sit ipsum pariatur mollit.',
    'Minim ex est enim amet et culpa enim deserunt.',
  ];

  static final _midResponses = List.generate(
    6,
    (index) => _shortResponses[index % _shortResponses.length],
  );

  static final _longResponses = List.generate(
    12,
    (index) => _shortResponses[index % _shortResponses.length],
  );

  static final _shortTitle = 'Excepteur labore quis cupidatat pariatur.';
  static final _midTitle =
      'Culpa excepteur sint eu dolor enim commodo culpa excepteur veniam aute aliqua eu voluptate Lorem. Et occaecat esse est veniam nisi commodo dolore ullamco nisi minim nostrud labore commodo duis.';
  static final _longTitle =
      'Tempor ex ut est dolore nostrud adipisicing pariatur dolor esse aute duis. Elit non et dolor sint. Nisi eiusmod in ullamco Lorem aute. Deserunt irure adipisicing eu tempor. Qui ex occaecat magna est. Ea consequat esse duis do veniam velit dolore nulla nostrud cupidatat nostrud reprehenderit enim eiusmod. Culpa non ex pariatur in amet enim exercitation anim officia aliqua elit est. Irure ut voluptate incididunt sit aliqua excepteur eu in.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ContentResponsiveWidget(
        responses: _shortResponses,
        // responses: _midResponses,
        // responses: _longResponses,
        // title: _shortTitle,
        // title: _midTitle,
        title: _longTitle,
        footerText: 'Footer text',
      ),
    );
  }
}
