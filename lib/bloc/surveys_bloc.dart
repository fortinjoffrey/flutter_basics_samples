// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/bloc/surveys_event.dart';
import 'package:flutter_basics_samples/bloc/surveys_state.dart';
import 'package:flutter_basics_samples/sources/mock_get_surveys_source.dart';
import 'package:value_state/value_state.dart';

class SurveysBloc extends Bloc<SurveysEvent, SurveysState> {
  SurveysBloc() : super(const SurveysState()) {
    on<SurveysEvent>((event, emit) async {
      switch (event) {
        case LoadSurveysEvent():
          await _onLoadSurveysEvent(event, emit);
        case PassSurveyEvent():
          await _onPassSurveyEvent(event, emit);
      }
    });
  }

  final GetSurveysSource _getSurveysSource = MockGetSurveysSource();

  Future<void> _getSurveys(int page, Emitter<SurveysState> emit) async {
    await state.surveysState.fetchFrom(() async {
      final surveys = await _getSurveysSource(page: page);
      return surveys;
    }).forEach((value) {
      if (value.isSuccess && !value.isFetching) {
        final surveys = value.data!;
        emit(
          state.copyWith(
            surveysState: Value.success([...state.surveysState.data ?? [], ...surveys]),
            currentPage: page,
            hasMore: surveys.length == GetSurveysSource.pageSize,
          ),
        );
      } else {
        emit(
          state.copyWith(surveysState: value),
        );
      }
    });
  }

  Future<void> _onLoadSurveysEvent(LoadSurveysEvent event, Emitter<SurveysState> emit) async {
    await _getSurveys(1, emit);
  }

  Future<void> _onPassSurveyEvent(PassSurveyEvent event, Emitter<SurveysState> emit) async {
    if (event.shouldBeMarkedAsSkipped) {
      print('Survey ${event.surveyId} shouldBeMarkedAsSkipped: ${event.shouldBeMarkedAsSkipped}');
    } else {
      print('Survey ${event.surveyId} shouldBeMarkedAsSkipped: ${event.shouldBeMarkedAsSkipped}');
    }

    // Pagination intelligente : charger seulement quand on approche de la fin
    final loadedSurveysCount = state.surveysState.data?.length ?? 0;
    final distanceToEnd = loadedSurveysCount - event.currentIndex - 1;
    final shouldPaginate = distanceToEnd <= 5 && state.hasMore;

    print('Current index: ${event.currentIndex}, Loaded surveys: $loadedSurveysCount, Distance to end: $distanceToEnd, Should paginate: $shouldPaginate');

    if (shouldPaginate) {
      print('🔄 Pagination déclenchée - chargement de la page ${state.currentPage + 1}');
      await _getSurveys(state.currentPage + 1, emit);
    }
  }
}
