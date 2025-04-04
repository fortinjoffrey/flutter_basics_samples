enum AnswerType {
  yesNo,
  likeDislike,
  doNotDo,
  goodBad,
  custom;

  bool get isPredefined => switch (this) {
        yesNo => true,
        likeDislike => true,
        doNotDo => true,
        goodBad => true,
        custom => false,
      };

  List<String>? get suggestions {
    switch (this) {
      case AnswerType.yesNo:
        return ['Yes', 'No'];
      case AnswerType.likeDislike:
        return ['I like', 'I dislike'];
      case AnswerType.doNotDo:
        return ['I do', 'I don\'t'];
      case AnswerType.goodBad:
        return ['Good opinion', 'Bad opinion'];
      case AnswerType.custom:
        return null;
    }
  }
}
