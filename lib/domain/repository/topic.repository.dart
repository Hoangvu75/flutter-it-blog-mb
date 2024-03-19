import 'package:injectable/injectable.dart';

import '../../data/api/topic/topic.api_client.dart';
import '../entities/topic.dart';
import '../requests/set_topics_request.dart';
import '../responses/base.response.dart';

@lazySingleton
class TopicRepository {
  final TopicApiClient apiClient = TopicApiClient();

  Future<BaseResponse<List<Topic>>> getTopics() async {
    final response = await apiClient.api.getTopics();
    var newResponse = BaseResponse<List<Topic>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var topics = response.parseList(Topic.fromJson);
    newResponse.data = topics;
    return newResponse;
  }

  Future<BaseResponse> setTopics(List<String> topicIds) async {
    final request = SetTopicsRequest(topicIds: topicIds);
    final response = await apiClient.api.setTopics(request.toMap());
    return response;
  }
}
