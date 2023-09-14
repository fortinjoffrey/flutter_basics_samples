import 'dart:convert';

import 'package:flutter_basics_samples/using_path_parameters/models/book.dart';
import 'package:flutter_basics_samples/using_path_parameters/screens/details_screen.dart';
import 'package:flutter_basics_samples/using_path_parameters/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:id/:count/:book',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final count = int.parse(state.pathParameters['count']!);
            final bookParams = state.pathParameters['book']!;
            final map = jsonDecode(bookParams) as Map<String, dynamic>;
            final book = Book.fromMap(map);

            return DetailsScreen(
              id: id,
              count: count,
              book: book,
            );
          },
        ),
      ],
    ),
  ],
);
