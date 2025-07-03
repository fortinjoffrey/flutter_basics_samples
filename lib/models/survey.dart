import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey.freezed.dart';

@freezed
abstract class Survey with _$Survey {
  const factory Survey({
    required String id,
    required String question,
    required bool displayResults,
  }) = _Survey;
}
