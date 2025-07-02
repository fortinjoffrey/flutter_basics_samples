abstract class SurveysEvent {
  const SurveysEvent();
}

class LoadSurveysEvent extends SurveysEvent {
  const LoadSurveysEvent();
}

class PassSurveyEvent extends SurveysEvent {
  const PassSurveyEvent({
    required this.surveyId, 
    required this.shouldBeMarkedAsSkipped,
    required this.currentIndex,
  });

  final String surveyId;
  final bool shouldBeMarkedAsSkipped;
  final int currentIndex;
}
