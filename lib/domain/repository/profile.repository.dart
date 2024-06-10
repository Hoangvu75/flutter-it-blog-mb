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

  Future<BaseResponse<Profile>> getProfile() async {
    final response = await apiClient.api.getProfile();
    var newResponse = BaseResponse<Profile>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    final profile = response.parse(Profile.fromJson);
    newResponse.data = profile;
    return newResponse;
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
    var mostFollowedProfiles =
        response.parsePaginationList(MostFollowedProfile.fromJson);
    newResponse.data = mostFollowedProfiles;
    return newResponse;
  }

  Future<BaseResponse<List<Profile>>> getFollowingProfiles({
    required int page,
    required int size,
    required String profileId,
  }) async {
    final response =
        await apiClient.api.getFollowingUsers(page, size, profileId);
    var newResponse = BaseResponse<List<Profile>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var followingProfiles = response.parsePaginationList(Profile.fromJson);
    newResponse.data = followingProfiles;
    return newResponse;
  }

  Future<BaseResponse<List<Profile>>> getFollowerProfiles({
    required int page,
    required int size,
    required String profileId,
  }) async {
    final response =
        await apiClient.api.getFollowerUsers(page, size, profileId);
    var newResponse = BaseResponse<List<Profile>>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    var followerProfiles = response.parsePaginationList(Profile.fromJson);
    newResponse.data = followerProfiles;
    return newResponse;
  }
}
