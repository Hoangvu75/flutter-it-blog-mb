import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/post.dart';

part 'current_reading_post.state.g.dart';

@Riverpod(keepAlive: true)
class CurrentReadingPost extends _$CurrentReadingPost {
  @override
  Post? build() {
    return null;
  }

  void setPost(Post post) {
    state = post;
  }

  void clearPost() {
    state = null;
  }
}
