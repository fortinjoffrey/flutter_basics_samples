// integration test should test the whole app
// or test individual part that makes sense together
// don't test a single widget in integration test because it will slow down testing suite
// since integration tests are run in a simulator

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/change_notifiers/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/models/article.dart';
import 'package:flutter_testing_tutorial/pages/article_page.dart';
import 'package:flutter_testing_tutorial/pages/news_page.dart';
import 'package:flutter_testing_tutorial/services/news_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class _MockNewsService extends Mock implements NewsService {}

void main() {
  late _MockNewsService mockNewsService;
  setUp(() {
    mockNewsService = _MockNewsService();
  });

  final articlesFromService = [
    Article(title: 'Test 1', content: 'Test 1 content'),
    Article(title: 'Test 2', content: 'Test 2 content'),
    Article(title: 'Test 3', content: 'Test 3 content'),
  ];

  void arrangeNewsServiceReturns3Articles() {
    when(() => mockNewsService.getArticles()).thenAnswer((_) async => articlesFromService);
  }

  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'News App',
      home: ChangeNotifierProvider(
        create: (_) => NewsChangeNotifier(mockNewsService),
        child: const NewsPage(),
      ),
    );
  }

  testWidgets(
    """Tapping on the first article excerpt opens the article page
    where the full article content is displayed""",
    (WidgetTester tester) async {
      arrangeNewsServiceReturns3Articles();

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();
      await tester.tap(find.text(articlesFromService.first.content));

      await tester.pumpAndSettle();

      expect(find.byType(NewsPage), findsNothing);
      expect(find.byType(ArticlePage), findsOneWidget);

      expect(find.text(articlesFromService.first.title), findsOneWidget);
      expect(find.text(articlesFromService.first.content), findsOneWidget);
    },
  );
}
