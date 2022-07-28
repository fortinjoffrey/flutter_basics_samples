import 'package:flutter/material.dart';

import 'problem_to_solve.dart';
import 'solution.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IntrinsicHeight and MultiChildRenderObjectWidget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Problem to solve',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            const ProblemToSolve(),
            const SizedBox(height: 16),
            const Text(
              'IntrinsicHeight and MultiChildRenderObjectWidget as a descendant seem to be incompatible',
            ),
            const SizedBox(height: 16),
            Text(
              'Solution',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 16),
            const Solution(),
          ],
        ),
      ),
    );
  }
}
