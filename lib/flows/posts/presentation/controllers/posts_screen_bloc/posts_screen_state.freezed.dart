// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posts_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostsScreenState {
  List<Post> get posts;

  /// Create a copy of PostsScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostsScreenStateCopyWith<PostsScreenState> get copyWith =>
      _$PostsScreenStateCopyWithImpl<PostsScreenState>(
          this as PostsScreenState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostsScreenState &&
            const DeepCollectionEquality().equals(other.posts, posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(posts));

  @override
  String toString() {
    return 'PostsScreenState(posts: $posts)';
  }
}

/// @nodoc
abstract mixin class $PostsScreenStateCopyWith<$Res> {
  factory $PostsScreenStateCopyWith(
          PostsScreenState value, $Res Function(PostsScreenState) _then) =
      _$PostsScreenStateCopyWithImpl;
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class _$PostsScreenStateCopyWithImpl<$Res>
    implements $PostsScreenStateCopyWith<$Res> {
  _$PostsScreenStateCopyWithImpl(this._self, this._then);

  final PostsScreenState _self;
  final $Res Function(PostsScreenState) _then;

  /// Create a copy of PostsScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
  }) {
    return _then(_self.copyWith(
      posts: null == posts
          ? _self.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _PostsScreenState implements PostsScreenState {
  const _PostsScreenState({final List<Post> posts = const []}) : _posts = posts;

  final List<Post> _posts;
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  /// Create a copy of PostsScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostsScreenStateCopyWith<_PostsScreenState> get copyWith =>
      __$PostsScreenStateCopyWithImpl<_PostsScreenState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostsScreenState &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_posts));

  @override
  String toString() {
    return 'PostsScreenState(posts: $posts)';
  }
}

/// @nodoc
abstract mixin class _$PostsScreenStateCopyWith<$Res>
    implements $PostsScreenStateCopyWith<$Res> {
  factory _$PostsScreenStateCopyWith(
          _PostsScreenState value, $Res Function(_PostsScreenState) _then) =
      __$PostsScreenStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Post> posts});
}

/// @nodoc
class __$PostsScreenStateCopyWithImpl<$Res>
    implements _$PostsScreenStateCopyWith<$Res> {
  __$PostsScreenStateCopyWithImpl(this._self, this._then);

  final _PostsScreenState _self;
  final $Res Function(_PostsScreenState) _then;

  /// Create a copy of PostsScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? posts = null,
  }) {
    return _then(_PostsScreenState(
      posts: null == posts
          ? _self._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

// dart format on
