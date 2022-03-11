import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/change_notifiers/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/pages/news_page.dart';
import 'package:flutter_testing_tutorial/services/news_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(NewsService()),
        child: const NewsPage(),
      ),
    );
  }
}
