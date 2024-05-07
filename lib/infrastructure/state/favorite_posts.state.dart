import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/post.dart';

part 'favorite_posts.state.g.dart';

@Riverpod(keepAlive: true)
class FavoritePostsState extends _$FavoritePostsState {
  @override
  List<Post> build() {
    return [];
  }

  void addPosts(List<Post> newPosts) {
    state = [...state, ...newPosts];
  }

  void addPost(Post newPost) {
    state = [newPost, ...state];
  }

  void removePost(Post post) {
    state = state.where((element) => element.id != post.id).toList();
  }
}
