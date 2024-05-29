// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      content: json['content'] as String?,
      isRepliedComment: json['isRepliedComment'] as bool?,
      repliedComments: (json['repliedComments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      author: json['author'] == null
          ? null
          : Profile.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'content': instance.content,
      'isRepliedComment': instance.isRepliedComment,
      'repliedComments': instance.repliedComments,
      'author': instance.author,
    };
