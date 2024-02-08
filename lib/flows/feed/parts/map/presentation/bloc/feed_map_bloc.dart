import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_event.dart';
import 'package:flutter_basics_samples/flows/feed/parts/map/presentation/bloc/feed_map_state.dart';
import 'package:flutter_basics_samples/dependencies_injector.dart';
import 'package:flutter_basics_samples/flows/location/domain/models/location_model.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/is_location_service_enabled.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/listen_for_location_updates.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/get_foreground_location_permission_status.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/request_foreground_location_permission.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class FeedMapBloc extends Bloc<FeedMapEvent, FeedMapState> {
  FeedMapBloc({
    IsLocationServiceEnabled? isLocationServiceEnabled,
    GetForegroundLocationPermissionStatus? getForegroundLocationPermissionStatus,
    RequestForegroundLocationPermissionStatus? requestForegroundLocationPermissionStatus,
    ListenForLocationUpdates? listenForLocationUpdates,
  })  : _isLocationServiceEnabled = isLocationServiceEnabled ?? sl<IsLocationServiceEnabled>(),
        _getForegroundLocationPermissionStatus =
            getForegroundLocationPermissionStatus ?? sl<GetForegroundLocationPermissionStatus>(),
        _requestForegroundLocationPermissionStatus =
            requestForegroundLocationPermissionStatus ?? sl<RequestForegroundLocationPermissionStatus>(),
        _listenForLocationUpdates = listenForLocationUpdates ?? sl<ListenForLocationUpdates>(),
        super(const FeedMapState()) {
    on<FeedMapEvent>((event, Emitter<FeedMapState> emit) async {
      switch (event) {
        case InitEvent():
          await _onInitEvent(emit);
          break;
        case FeedAppResumedEvent():
          await _onFeedAppResumedEvent(emit);
          break;
        case SwitchMapModeEvent():
          emit(state.copyWith(mode: event.mode));
          break;
        case LocationUpdateEvent():
          _onLocationUpdateEvent(event, emit);
          break;
        case OnWillDisappear():
          _locationStreamSubscription?.cancel();
          break;
        case OnWillAppearEvent():
          if (_locationStreamSubscription != null) {
            final locationStream = await _listenForLocationUpdates();
            _locationStreamSubscription = locationStream.listen((LocationModel locationModel) {
              print(locationModel);
              final latitude = locationModel.latitude;
              final longitude = locationModel.longitude;

              if (latitude == null || longitude == null) {
                return;
              }

              add(LocationUpdateEvent(LatLng(latitude, longitude)));
            });
          }
        case LockOnMeEvent():
          emit(state.copyWith(mode: const CenterOnUserLocationMapMode()));
        case FreeModeEvent():
          emit(state.copyWith(mode: const FreeMoveMapMode()));
      }
    });
  }

  StreamSubscription<LocationModel>? _locationStreamSubscription;

  @override
  void onTransition(Transition<FeedMapEvent, FeedMapState> transition) {
    log('Event: ${transition.event}', name: 'FeedMapBloc');
    log('State: ${transition.nextState}', name: 'FeedMapBloc');
    super.onTransition(transition);
  }

  final IsLocationServiceEnabled _isLocationServiceEnabled;
  final GetForegroundLocationPermissionStatus _getForegroundLocationPermissionStatus;
  final RequestForegroundLocationPermissionStatus _requestForegroundLocationPermissionStatus;
  final ListenForLocationUpdates _listenForLocationUpdates;

  Future<void> _onInitEvent(Emitter<FeedMapState> emit) async {
    await _checkLocationServiceAndPermissionStatus(emit);
  }

    Future<void> _onFeedAppResumedEvent(Emitter<FeedMapState> emit) async {
    PermissionStatus permissionStatus = await _getForegroundLocationPermissionStatus.call();

    emit(state.copyWith(permissionStatus: permissionStatus));
    // if (granted) => start location updates
  }

  Future<void> _checkLocationServiceAndPermissionStatus(Emitter<FeedMapState> emit) async {
    final isLocationServiceEnabled = await _isLocationServiceEnabled.call();
    if (!isLocationServiceEnabled) return;

    PermissionStatus permissionStatus = await _getForegroundLocationPermissionStatus.call();

    if (permissionStatus.isDenied) {
      permissionStatus = await _requestForegroundLocationPermissionStatus.call();
    }

    if (!permissionStatus.isGranted) {
      // at this point if not granted then emit state with this status
      return;
    }

    if (permissionStatus.isGranted && (state.permissionStatus?.isGranted == true)) {
      return;
    }

    emit(state.copyWith(permissionStatus: permissionStatus));

    final locationStream = await _listenForLocationUpdates();

    int last = DateTime.now().millisecondsSinceEpoch;

    _locationStreamSubscription = locationStream.listen((LocationModel locationModel) {
      print(locationModel);
      final latitude = locationModel.latitude;
      final longitude = locationModel.longitude;

      if (latitude == null || longitude == null) {
        return;
      }
      int cur = DateTime.now().millisecondsSinceEpoch;
      int ellapsedTime = last - cur;
      last = cur;
      log('ellapsedTime: $ellapsedTime', name: 'Time');

      add(LocationUpdateEvent(LatLng(latitude, longitude)));
    });
  }

  void _onLocationUpdateEvent(LocationUpdateEvent event, Emitter<FeedMapState> emit) {
    emit(state.copyWith(userLocation: event.latLng));
  }
}
