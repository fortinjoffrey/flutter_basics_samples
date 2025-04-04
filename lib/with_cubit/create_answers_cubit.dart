import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/models/answer_type.dart';
import 'package:flutter_basics_samples/with_cubit/create_answers_cubit_state.dart';

class CreateAnswersCubit extends Cubit<CreateAnswersCubitState> {
  CreateAnswersCubit() : super(const CreateAnswersCubitState());

  void setAnswerType(AnswerType? answerType) {
    emit(state.copyWith(
      answerType: answerType,
      answers: answerType?.suggestions ?? ['', ''],
    ));
  }

  void updateAnswer(String answer, int index) {
    final answers = List<String>.from(state.answers);
    answers[index] = answer;
    emit(state.copyWith(answers: answers));
  }

  void clearAnswer(int index) {
    updateAnswer('', index);
  }

  void addAnswer() {
    emit(state.copyWith(answers: [...state.answers, '']));
  }

  void removeAnswer(int index) {
    final answers = List<String>.from(state.answers);
    answers.removeAt(index);
    emit(state.copyWith(answers: answers));
  }
}
