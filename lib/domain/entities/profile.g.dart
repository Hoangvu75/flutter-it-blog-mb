// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileImpl _$$ProfileImplFromJson(Map<String, dynamic> json) =>
    _$ProfileImpl(
      id: json['id'] as String?,
      account: json['account'] == null
          ? null
          : Account.fromJson(json['account'] as Map<String, dynamic>),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      favoriteTopics: (json['favoriteTopics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$ProfileImplToJson(_$ProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth,
      'phone': instance.phone,
      'address': instance.address,
      'gender': instance.gender,
      'avatarUrl': instance.avatarUrl,
      'favoriteTopics': instance.favoriteTopics,
      'createdAt': instance.createdAt,
    };
