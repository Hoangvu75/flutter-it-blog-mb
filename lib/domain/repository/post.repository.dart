import 'package:injectable/injectable.dart';

import '../../data/api/post/post.api_client.dart';
import '../entities/post.dart';
import '../responses/base.response.dart';

@lazySingleton
class PostRepository {
  final apiClient = PostApiClient();

  Future<BaseResponse<List<Post>>> getPosts() async {
    final response = await apiClient.api.getRecentPosts();
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
