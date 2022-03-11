import 'package:flutter/material.dart';
import 'package:flutter_testing_tutorial/models/article.dart';
import 'package:flutter_testing_tutorial/services/news_service.dart';

class NewsChangeNotifier extends ChangeNotifier {
  final NewsService _newsService;

  NewsChangeNotifier(this._newsService);

  final List<Article> _articles = [];

  List<Article> get articles => _articles;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    // TODO: Implement
  }
}
