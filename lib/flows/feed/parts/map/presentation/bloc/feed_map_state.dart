import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

part 'feed_map_state.freezed.dart';

@freezed
class FeedMapState with _$FeedMapState {
  const factory FeedMapState({
    @Default(FreeMoveMapMode()) MapMode mode,
    PermissionStatus? permissionStatus,
    LatLng? userLocation,
  }) = _FeedMapState;
}
