import 'package:equatable/equatable.dart';

abstract class Failure {}

class InvalidInputFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
