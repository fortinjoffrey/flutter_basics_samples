import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const factory DataState.initial() = _Initial<T>;
  const factory DataState.pending() = _Pending<T>;
  const factory DataState.failure(String message) = _Failure<T>;
  const factory DataState.complete(T data) = _Complete<T>;
}
