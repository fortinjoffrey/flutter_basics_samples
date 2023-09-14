import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/using_path_parameters/models/book.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.id,
    required this.count,
    required this.book,
  });

  final String id;
  final int count;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('id: $id'), Text('count: $count'), Text('Book: $book')],
        ),
      ),
    );
  }
}
