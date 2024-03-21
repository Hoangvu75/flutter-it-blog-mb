import 'package:injectable/injectable.dart';

import '../../data/api/profile/profile.api_client.dart';
import '../entities/profile.dart';
import '../requests/create_profile.request.dart';
import '../responses/base.response.dart';

@lazySingleton
class ProfileRepository {
  final ProfileApiClient apiClient = ProfileApiClient();

  Future<BaseResponse> createProfile(CreateProfileRequest request) async {
    final response = await apiClient.api.createProfile(request.toMap());
    return response;
  }

  Future<BaseResponse<List<MostFollowedProfile>>> getMostFollowedProfiles({
    required int page,
    required int size,
  }) async {
    final response = await apiClient.api.getMostFollowedProfiles(page, size);
    var newResponse = BaseResponse<List<MostFollowedProfile>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var mostFollowedProfiles = response.parsePaginationList(MostFollowedProfile.fromJson);
    newResponse.data = mostFollowedProfiles;
    return newResponse;
  }
}
