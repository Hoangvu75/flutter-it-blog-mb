import 'package:injectable/injectable.dart';

import '../../data/api/follow/follow.api_client.dart';
import '../responses/base.response.dart';

@lazySingleton
class FollowRepository {
  final FollowApiClient apiClient = FollowApiClient();

  Future<BaseResponse> follow(String profileId) async {
    final response = await apiClient.api.follow(profileId, {});
    return response;
  }

  Future<BaseResponse> unfollow(String profileId) async {
    final response = await apiClient.api.unfollow(profileId, {});
    return response;
  }

  Future<BaseResponse> followMultiple(List<String> profileIds) async {
    final request = {
      'profileIds': profileIds,
    };
    final response = await apiClient.api.followMultiple(request);
    return response;
  }
}
