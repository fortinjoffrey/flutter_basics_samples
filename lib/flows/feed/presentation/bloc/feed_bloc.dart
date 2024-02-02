import 'package:bloc/bloc.dart';
import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/feed/domain/usecases/is_location_service_enabled.dart';
import 'package:flutter_basics_samples/flows/feed/presentation/bloc/feed_bloc_state.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/get_foreground_location_permission_status.dart';
import 'package:flutter_basics_samples/flows/permission/domain/usecases/request_foreground_location_permission.dart';
import 'package:permission_handler/permission_handler.dart';

part 'feed_bloc_event.dart';

class FeedBloc extends Bloc<FeedBlocEvent, FeedBlocState> {
  FeedBloc({
    IsLocationServiceEnabled? isLocationServiceEnabled,
    GetForegroundLocationPermissionStatus? getForegroundLocationPermissionStatus,
    RequestForegroundLocationPermissionStatus? requestForegroundLocationPermissionStatus,
  })  : _isLocationServiceEnabled = isLocationServiceEnabled ?? sl<IsLocationServiceEnabled>(),
        _getForegroundLocationPermissionStatus =
            getForegroundLocationPermissionStatus ?? sl<GetForegroundLocationPermissionStatus>(),
        _requestForegroundLocationPermissionStatus =
            requestForegroundLocationPermissionStatus ?? sl<RequestForegroundLocationPermissionStatus>(),
        super(const FeedBlocState()) {
    on<FeedBlocEvent>((event, Emitter<FeedBlocState> emit) {
      switch (event) {
        case ToggleDisplayModeEvent():
          _onToggleDisplayModeEvent(emit);
          break;
        case InitEvent():
          _onInitEvent(emit);
          break;
        case FeedAppResumedEvent():
          _onFeedAppResumedEvent(emit);
      }
    });
  }

  final IsLocationServiceEnabled _isLocationServiceEnabled;
  final GetForegroundLocationPermissionStatus _getForegroundLocationPermissionStatus;
  final RequestForegroundLocationPermissionStatus _requestForegroundLocationPermissionStatus;

  void _onToggleDisplayModeEvent(Emitter<FeedBlocState> emit) {
    emit(
      state.copyWith(
        displayMode:
            state.displayMode == const FeedMapDisplayMode() ? const FeedListDisplayMode() : const FeedMapDisplayMode(),
      ),
    );
  }

  void _onInitEvent(Emitter<FeedBlocState> emit) async {
    _checkLocationServiceAndPermissionStatus();
  }

  void _onFeedAppResumedEvent(Emitter<FeedBlocState> emit) async {
    _checkLocationServiceAndPermissionStatus();
  }

  void _checkLocationServiceAndPermissionStatus() async {
    final isLocationServiceEnabled = _isLocationServiceEnabled.call();
    if (!isLocationServiceEnabled) return;

    PermissionStatus permissionStatus = await _getForegroundLocationPermissionStatus.call();

    if (permissionStatus.isDenied) {
      permissionStatus = await _requestForegroundLocationPermissionStatus.call();
    }

    if (!permissionStatus.isGranted) {
      // at this point if not granted then emit state with this status
      return;
    }

    // at this point the permission is granted
  }
}
