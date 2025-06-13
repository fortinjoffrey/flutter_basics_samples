// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminState {
  AdminTabs get tab;

  /// Create a copy of AdminState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdminStateCopyWith<AdminState> get copyWith =>
      _$AdminStateCopyWithImpl<AdminState>(this as AdminState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdminState &&
            (identical(other.tab, tab) || other.tab == tab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab);

  @override
  String toString() {
    return 'AdminState(tab: $tab)';
  }
}

/// @nodoc
abstract mixin class $AdminStateCopyWith<$Res> {
  factory $AdminStateCopyWith(
          AdminState value, $Res Function(AdminState) _then) =
      _$AdminStateCopyWithImpl;
  @useResult
  $Res call({AdminTabs tab});
}

/// @nodoc
class _$AdminStateCopyWithImpl<$Res> implements $AdminStateCopyWith<$Res> {
  _$AdminStateCopyWithImpl(this._self, this._then);

  final AdminState _self;
  final $Res Function(AdminState) _then;

  /// Create a copy of AdminState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tab = null,
  }) {
    return _then(_self.copyWith(
      tab: null == tab
          ? _self.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as AdminTabs,
    ));
  }
}

/// @nodoc

class _AdminState implements AdminState {
  const _AdminState({this.tab = AdminTabs.dashboard});

  @override
  @JsonKey()
  final AdminTabs tab;

  /// Create a copy of AdminState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdminStateCopyWith<_AdminState> get copyWith =>
      __$AdminStateCopyWithImpl<_AdminState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdminState &&
            (identical(other.tab, tab) || other.tab == tab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab);

  @override
  String toString() {
    return 'AdminState(tab: $tab)';
  }
}

/// @nodoc
abstract mixin class _$AdminStateCopyWith<$Res>
    implements $AdminStateCopyWith<$Res> {
  factory _$AdminStateCopyWith(
          _AdminState value, $Res Function(_AdminState) _then) =
      __$AdminStateCopyWithImpl;
  @override
  @useResult
  $Res call({AdminTabs tab});
}

/// @nodoc
class __$AdminStateCopyWithImpl<$Res> implements _$AdminStateCopyWith<$Res> {
  __$AdminStateCopyWithImpl(this._self, this._then);

  final _AdminState _self;
  final $Res Function(_AdminState) _then;

  /// Create a copy of AdminState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tab = null,
  }) {
    return _then(_AdminState(
      tab: null == tab
          ? _self.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as AdminTabs,
    ));
  }
}

// dart format on
