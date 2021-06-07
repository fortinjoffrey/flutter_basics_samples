import 'package:basics_samples/my_column_widget.dart';
import 'package:basics_samples/my_column_with_expanded_widget.dart';
import 'package:basics_samples/my_grid_view.dart';
import 'package:basics_samples/my_list_view.dart';
import 'package:basics_samples/my_row_widget.dart';
import 'package:basics_samples/my_stack_widget.dart';
import 'package:flutter/material.dart';

import 'my_responsive_grid_view.dart';

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
      // home: Scaffold(body: SafeArea(child: MyColumnWidget())),
      home: Scaffold(body: SafeArea(child: MyResponsiveGridView())),
      // home: Scaffold(body: SafeArea(child: MyGridView())),
      // home: Scaffold(body: SafeArea(child: MyListView())),
      // home: Scaffold(body: SafeArea(child: ColumnOverflowWidget())),
      // home: Scaffold(body: SafeArea(child: MyRowWidget())),
      // home: Scaffold(body: SafeArea(child: MyStackWidget())),
    );
  }
}
