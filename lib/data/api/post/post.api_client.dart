import '../base_api_client.dart';
import 'post.api.dart';

class PostApiClient extends BaseApiClient {
  late final PostApi api;

  PostApiClient() {
    api = PostApi(dio);
  }
}