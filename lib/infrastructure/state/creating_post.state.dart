import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'creating_post.state.g.dart';

@Riverpod(keepAlive: true)
class CreatingPostState extends _$CreatingPostState {
  @override
  CreatingPost build() {
    return CreatingPost();
  }

  void setTitle(String? value) {
    state = state.copyWith(title: value);
  }

  void setDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void setContent(File? value) {
    state = state.copyWith(content: value);
  }

  void setThumbnail(File? value) {
    state = state.copyWith(thumbnail: value);
  }

  void setTopicIds(List<String>? value) {
    state = state.copyWith(topicIds: value);
  }
}

class CreatingPost {
  String? title;
  String? description;
  File? content;
  File? thumbnail;
  List<String>? topicIds;

  CreatingPost({
    this.title,
    this.description,
    this.content,
    this.thumbnail,
    this.topicIds,
  });

  CreatingPost copyWith({
    String? title,
    String? description,
    File? content,
    File? thumbnail,
    List<String>? topicIds,
  }) {
    return CreatingPost(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      thumbnail: thumbnail ?? this.thumbnail,
      topicIds: topicIds ?? this.topicIds,
    );
  }

  @override
  String toString() {
    return 'CreatingPost{title: $title, description: $description, content: $content, thumbnail: $thumbnail, topicIds: $topicIds}';
  }
}