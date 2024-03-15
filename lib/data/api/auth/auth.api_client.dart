import '../base_api_client.dart';
import 'auth.api.dart';

class AuthApiClient extends BaseApiClient {
  late final AuthApi api;

  AuthApiClient() {
    api = AuthApi(dio);
  }
}