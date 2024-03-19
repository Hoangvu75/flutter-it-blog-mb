import '../base_api_client.dart';
import 'topic.api.dart';

class TopicApiClient extends BaseApiClient {
  late final TopicApi api;

  TopicApiClient() {
    api = TopicApi(dio);
  }
}