import 'package:injectable/injectable.dart';

import '../../data/api/post/post.api_client.dart';
import '../../infrastructure/state/creating_post.state.dart';
import '../entities/comment.dart';
import '../entities/post.dart';
import '../entities/profile.dart';
import '../responses/base.response.dart';

@lazySingleton
class PostRepository {
  final apiClient = PostApiClient();

  Future<BaseResponse<List<Post>>> getPosts({int? page, int? size}) async {
    final response = await apiClient.api.getRecentPosts(
      page ?? 0,
      size ?? 10,
    );
    var newResponse = BaseResponse<List<Post>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var topics = response.parsePaginationList(Post.fromJson);
    newResponse.data = topics;
    return newResponse;
  }

  Future<BaseResponse<List<Post>>> getPostsByTopicId({
    int? page,
    int? size,
    required String topicId,
  }) async {
    final response = await apiClient.api.getRecentPostsByTopic(
      page ?? 0,
      size ?? 10,
      topicId,
    );
    var newResponse = BaseResponse<List<Post>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var topics = response.parsePaginationList(Post.fromJson);
    newResponse.data = topics;
    return newResponse;
  }

  Future<BaseResponse<List<Post>>> searchPost({
    int? page,
    int? size,
    required String searchKey,
  }) async {
    final response = await apiClient.api.searchPostsByTopic(
      page ?? 0,
      size ?? 10,
      searchKey,
    );
    var newResponse = BaseResponse<List<Post>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var topics = response.parsePaginationList(Post.fromJson);
    newResponse.data = topics;
    return newResponse;
  }

  Future<BaseResponse<List<Post>>> getFavoritePosts({
    int? page,
    int? size,
  }) async {
    final response = await apiClient.api.getFavoritePost(
      page ?? 0,
      size ?? 10,
    );
    var newResponse = BaseResponse<List<Post>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var topics = response.parsePaginationList(Post.fromJson);
    newResponse.data = topics;
    return newResponse;
  }

  Future<BaseResponse> createPost({required CreatingPost creatingPost}) async {
    final response = await apiClient.api.createPost(
      creatingPost.content!,
      creatingPost.thumbnail!,
      creatingPost.title!,
      creatingPost.description!,
      creatingPost.topicIds!,
    );
    return BaseResponse(
      code: response.code,
      success: response.success,
      error: response.error,
    );
  }

  Future<BaseResponse<List<Profile>>> getPostLikeProfiles({
    required String postId,
  }) async {
    final response = await apiClient.api.getPostLikes(postId);
    var newResponse = BaseResponse<List<Profile>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var profiles = response.parseList(Profile.fromJson);
    newResponse.data = profiles;
    return newResponse;
  }

  Future<BaseResponse<List<Comment>>> getPostComments({
    required String postId,
  }) async {
    final response = await apiClient.api.getPostComments(postId);
    var newResponse = BaseResponse<List<Comment>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var comments = response.parseList(Comment.fromJson);
    newResponse.data = comments;
    return newResponse;
  }

  Future<BaseResponse<List<Post>>> getPostsByAuthorId({
    int? page,
    int? size,
    required String authorId,
  }) async {
    final response = await apiClient.api.getPostsByAuthor(
      page ?? 0,
      size ?? 10,
      authorId,
    );
    var newResponse = BaseResponse<List<Post>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var posts = response.parsePaginationList(Post.fromJson);
    newResponse.data = posts;
    return newResponse;
  }
}
