abstract class Failure {}

class InvalidInputFailure extends Failure {
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InvalidInputFailure && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
