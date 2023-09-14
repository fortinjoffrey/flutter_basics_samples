import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/using_path_parameters/models/book.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              final Book book1 = Book(name: 'Book 1', author: 'Author 1');
              final map = book1.toMap();
              final st = jsonEncode(map);
              context.go('/details/iD2s/99/$st');
            },
            child: const Text('Go to /details/iD2s/99/st')),
      ),
    );
  }
}
