import 'package:injectable/injectable.dart';

import '../../data/api/profile/profile.api_client.dart';
import '../requests/create_profile.request.dart';
import '../responses/base.response.dart';

@lazySingleton
class ProfileRepository {
  final ProfileApiClient apiClient = ProfileApiClient();

  Future<BaseResponse> createProfile(CreateProfileRequest request) async {
    final response = await apiClient.api.createProfile(request.toMap());
    return response;
  }
}