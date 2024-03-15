// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) =>
    BaseResponse<T>(
      code: json['code'] as int?,
      data: json['data'],
      success: json['success'] as bool?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$BaseResponseToJson<T>(BaseResponse<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'success': instance.success,
      'error': instance.error,
    };
