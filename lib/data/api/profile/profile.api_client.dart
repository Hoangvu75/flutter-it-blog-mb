import '../base_api_client.dart';
import 'profile.api.dart';

class ProfileApiClient extends BaseApiClient {
  late final ProfileApi api;

  ProfileApiClient() {
    api = ProfileApi(dio);
  }
}