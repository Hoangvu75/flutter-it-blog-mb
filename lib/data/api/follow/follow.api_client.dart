import '../base_api_client.dart';
import 'follow.api.dart';

class FollowApiClient extends BaseApiClient {
  late final FollowApi api;

  FollowApiClient() {
    api = FollowApi(dio);
  }
}