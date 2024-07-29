import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/usage_examples/custom_scroll_view_auto_scroll_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomScrollViewAutoScrollPage(),
    );
  }
}
