import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_tutorial/change_notifiers/news_change_notifier.dart';
import 'package:flutter_testing_tutorial/models/article.dart';
import 'package:flutter_testing_tutorial/services/news_service.dart';
import 'package:mocktail/mocktail.dart';

class _MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsChangeNotifier sut;
  late _MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = _MockNewsService();
    sut = NewsChangeNotifier(mockNewsService);
  });

  test(
    "initial values are correct",
    () async {
      expect(sut.articles, []);
      expect(sut.isLoading, false);
    },
  );

  group('getArticles', () {
    final articlesFromService = [
      Article(title: 'Test 1', content: 'Test 1 content'),
      Article(title: 'Test 2', content: 'Test 2 content'),
      Article(title: 'Test 3', content: 'Test 3 content'),
    ];

    void arrangeNewsServiceReturns3Articles() {
      when(() => mockNewsService.getArticles()).thenAnswer((_) async => articlesFromService);
    }

    test(
      "gets articles using the news services",
      () async {
        arrangeNewsServiceReturns3Articles();

        await sut.getArticles();
        verify(mockNewsService.getArticles).called(1);
      },
    );

    test(
      """indicates loading of data, 
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
      () async {
        arrangeNewsServiceReturns3Articles();

        final future = sut.getArticles();

        expect(sut.isLoading, true);

        await future;

        expect(sut.articles, articlesFromService);

        expect(sut.isLoading, false);
      },
    );
  });
}
