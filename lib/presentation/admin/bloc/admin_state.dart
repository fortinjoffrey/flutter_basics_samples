import 'package:flutter_basics_samples/presentation/admin/bloc/admin_bloc_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_state.freezed.dart';

@freezed
abstract class AdminState with _$AdminState {
  const factory AdminState({
    @Default(AdminTabs.dashboard) AdminTabs tab,
  }) = _AdminState;
}
