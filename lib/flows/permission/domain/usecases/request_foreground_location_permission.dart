import 'package:flutter_basics_samples/dependy_injector.dart';
import 'package:flutter_basics_samples/flows/permission/repository/permission_repository.dart';
import 'package:flutter_basics_samples/shared/domain/usecases/usecase.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestForegroundLocationPermissionStatus implements UseCase<Future<PermissionStatus>, void> {
  RequestForegroundLocationPermissionStatus({
    PermissionRepository? permissionRepository,
  }) : _permissionRepository = permissionRepository ?? sl<PermissionRepository>();

  final PermissionRepository _permissionRepository;

  @override
  Future<PermissionStatus> call([void params]) async {
    return await _permissionRepository.requestLocationPermissionStatus();
  }
}
