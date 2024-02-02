import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_handler/permission_handler.dart';

part 'feed_bloc_state.freezed.dart';

@freezed
class FeedBlocState with _$FeedBlocState {
  const factory FeedBlocState({
    @Default(FeedMapDisplayMode()) FeedDisplayMode displayMode,
    PermissionStatus? permissionStatus,
  }) = _FeedBlocState;
}
