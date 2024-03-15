// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignInTokens _$SignInTokensFromJson(Map<String, dynamic> json) {
  return _SignInTokens.fromJson(json);
}

/// @nodoc
mixin _$SignInTokens {
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  Profile? get profile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignInTokensCopyWith<SignInTokens> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInTokensCopyWith<$Res> {
  factory $SignInTokensCopyWith(
          SignInTokens value, $Res Function(SignInTokens) then) =
      _$SignInTokensCopyWithImpl<$Res, SignInTokens>;
  @useResult
  $Res call({String? accessToken, String? refreshToken, Profile? profile});

  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$SignInTokensCopyWithImpl<$Res, $Val extends SignInTokens>
    implements $SignInTokensCopyWith<$Res> {
  _$SignInTokensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? profile = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProfileCopyWith<$Res>? get profile {
    if (_value.profile == null) {
      return null;
    }

    return $ProfileCopyWith<$Res>(_value.profile!, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignInTokensImplCopyWith<$Res>
    implements $SignInTokensCopyWith<$Res> {
  factory _$$SignInTokensImplCopyWith(
          _$SignInTokensImpl value, $Res Function(_$SignInTokensImpl) then) =
      __$$SignInTokensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? accessToken, String? refreshToken, Profile? profile});

  @override
  $ProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$$SignInTokensImplCopyWithImpl<$Res>
    extends _$SignInTokensCopyWithImpl<$Res, _$SignInTokensImpl>
    implements _$$SignInTokensImplCopyWith<$Res> {
  __$$SignInTokensImplCopyWithImpl(
      _$SignInTokensImpl _value, $Res Function(_$SignInTokensImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? profile = freezed,
  }) {
    return _then(_$SignInTokensImpl(
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      profile: freezed == profile
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignInTokensImpl implements _SignInTokens {
  _$SignInTokensImpl({this.accessToken, this.refreshToken, this.profile});

  factory _$SignInTokensImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignInTokensImplFromJson(json);

  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final Profile? profile;

  @override
  String toString() {
    return 'SignInTokens(accessToken: $accessToken, refreshToken: $refreshToken, profile: $profile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInTokensImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, profile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInTokensImplCopyWith<_$SignInTokensImpl> get copyWith =>
      __$$SignInTokensImplCopyWithImpl<_$SignInTokensImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignInTokensImplToJson(
      this,
    );
  }
}

abstract class _SignInTokens implements SignInTokens {
  factory _SignInTokens(
      {final String? accessToken,
      final String? refreshToken,
      final Profile? profile}) = _$SignInTokensImpl;

  factory _SignInTokens.fromJson(Map<String, dynamic> json) =
      _$SignInTokensImpl.fromJson;

  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  Profile? get profile;
  @override
  @JsonKey(ignore: true)
  _$$SignInTokensImplCopyWith<_$SignInTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
