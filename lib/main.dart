import 'package:flutter/material.dart';
import 'package:flutter_basics_samples/with_cubit/home_page_with_cubit.dart';

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
      home: const HomePageWithCubit(title: 'Flutter Demo Home Page'),
    );
  }
}
