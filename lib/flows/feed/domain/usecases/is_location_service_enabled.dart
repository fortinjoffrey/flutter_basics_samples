import 'package:flutter_basics_samples/shared/domain/usecases/usecase.dart';

class IsLocationServiceEnabled implements UseCase<bool, void> {
  IsLocationServiceEnabled();

  @override
  bool call([void params]) {
    // TODO: (JFO) 
    return true;
  }
}
