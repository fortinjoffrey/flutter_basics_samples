import 'package:basics_samples/models.dart';
import 'package:bloc/bloc.dart';

abstract class ReconstructWidgetState {}

class ReconstructWidgetStateLoading implements ReconstructWidgetState {}

class ReconstructWidgetStateComplete implements ReconstructWidgetState {
  final PositionInformation positionInformation;

  const ReconstructWidgetStateComplete({required this.positionInformation});
}

class ReconstructWidgetStateError implements ReconstructWidgetState {}

class ReconstructWidgetCubit extends Cubit<ReconstructWidgetState> {
  Map<String, dynamic> json;

  ReconstructWidgetCubit(this.json) : super(ReconstructWidgetStateLoading());

  Future<void> init() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    emit(ReconstructWidgetStateComplete(positionInformation: PositionInformation.fromMap(json)));
  }

  Future<void> refresh(Map<String, dynamic> updatedJson) async {
    json = updatedJson;
    emit(ReconstructWidgetStateComplete(positionInformation: PositionInformation.fromMap(json)));
  }
}
