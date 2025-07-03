import 'package:flutter_basics_samples/models/survey.dart';



abstract class GetSurveysSource {
  static const pageSize = 10;

  Future<List<Survey>> call({
    required int page,
  });
}

class MockGetSurveysSource implements GetSurveysSource {
  @override
  Future<List<Survey>> call({required int page}) async {
    await Future.delayed(Duration(milliseconds: 500));

    final allSurveys = List.generate(
        10,
        (index) => Survey(
              id: index.toString(),
              question: 'Question $index',
              displayResults: false,
            ));

    final startIndex = (page - 1) * GetSurveysSource.pageSize;
    final endIndex = (startIndex + GetSurveysSource.pageSize).clamp(0, allSurveys.length);

    if (startIndex >= allSurveys.length) {
      return [];
    }

    return allSurveys.sublist(startIndex, endIndex);
  }
}
