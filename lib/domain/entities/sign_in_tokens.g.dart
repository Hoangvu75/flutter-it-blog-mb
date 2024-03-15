// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignInTokensImpl _$$SignInTokensImplFromJson(Map<String, dynamic> json) =>
    _$SignInTokensImpl(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SignInTokensImplToJson(_$SignInTokensImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'profile': instance.profile,
    };
