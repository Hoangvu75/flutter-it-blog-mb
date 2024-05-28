import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    String? id,
    String? createdAt,
    String? content,
    bool? isRepliedComment,
    List<Comment>? repliedComments,
    Profile? author,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}