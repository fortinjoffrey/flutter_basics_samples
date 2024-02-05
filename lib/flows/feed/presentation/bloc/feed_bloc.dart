import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/is_location_service_enabled.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc_state.dart';
import 'package:flutter_basics_samples/flows/location/domain/usecases/listen_for_location_updates.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/get_foreground_location_permission_status.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/request_foreground_location_permission.dart';
import 'package:permission_handler/permission_handler.dart';

part 'feed_bloc_event.dart';

class FeedBloc extends Bloc<FeedBlocEvent, FeedBlocState> {
  FeedBloc({
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
        super(const FeedBlocState()) {
    print('FeedBloc created');
    on<FeedBlocEvent>((event, Emitter<FeedBlocState> emit) async {
      switch (event) {
        case ToggleDisplayModeEvent():
          _onToggleDisplayModeEvent(emit);
          break;
      }
    });
  }

  final IsLocationServiceEnabled _isLocationServiceEnabled;
  final GetForegroundLocationPermissionStatus _getForegroundLocationPermissionStatus;
  final RequestForegroundLocationPermissionStatus _requestForegroundLocationPermissionStatus;
  final ListenForLocationUpdates _listenForLocationUpdates;

  void _onToggleDisplayModeEvent(Emitter<FeedBlocState> emit) {
    emit(
      state.copyWith(
        displayMode:
            state.displayMode == const FeedMapDisplayMode() ? const FeedListDisplayMode() : const FeedMapDisplayMode(),
      ),
    );
  }
}
