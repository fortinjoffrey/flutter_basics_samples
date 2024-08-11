import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/old/custom_scroll_view_reversed_page.dart';
import 'package:flutter_basics_samples/old/list_view_reversed_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomScrollViewReversedPage(),
      // home: ListViewReversedPage(),
      // home: CustomScrollViewAutoScrollPage(),
    );
  }
}
