import 'package:injectable/injectable.dart';

import '../../data/api/post/post.api_client.dart';
import '../entities/post.dart';
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
}
