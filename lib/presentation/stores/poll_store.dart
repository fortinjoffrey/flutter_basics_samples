import 'package:basics_samples/presentation/stores/auth_store.dart';
import 'package:mobx/mobx.dart';

part 'poll_store.g.dart';

class PollsStore = _PollsStore with _$PollsStore;

abstract class _PollsStore with Store {

  // ignore: unused_field
  final AuthStore _authStore;

  _PollsStore ({
    required AuthStore authStore,
  }): _authStore = authStore;




  //----------------------------------------------------------------------------
  // OBSERVABLE PROPERTIES AND GETTERS
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // ACTIONS
  //----------------------------------------------------------------------------
}