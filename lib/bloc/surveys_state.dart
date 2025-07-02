import 'package:flutter_basics_samples/models/survey.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:value_state/value_state.dart';

part 'surveys_state.freezed.dart';

@freezed
abstract class SurveysState with _$SurveysState {
  const factory SurveysState({
    @Default(Value.initial()) Value<List<Survey>> surveysState,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
  }) = _SurveysState;
}
