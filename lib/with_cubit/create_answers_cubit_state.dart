import 'package:flutter_basics_samples/models/answer_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_answers_cubit_state.freezed.dart';

@freezed
class CreateAnswersCubitState with _$CreateAnswersCubitState {
  const factory CreateAnswersCubitState({
    @Default([]) List<String> answers,
    AnswerType? answerType,
  }) = _CreateAnswersCubitState;
}
