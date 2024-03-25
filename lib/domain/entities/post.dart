import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';
import 'topic.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    String? id,
    bool? isActive,
    String? createdAt,
    String? title,
    String? description,
    String? contentUrl,
    String? thumbnailUrl,
    List<Topic>? topics,
    Profile? author,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}