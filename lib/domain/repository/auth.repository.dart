import 'package:injectable/injectable.dart';

import '../../data/api/auth/auth.api_client.dart';
import '../entities/sign_in_tokens.dart';
import '../requests/google_sign_in.request.dart';
import '../requests/sign.request.dart';
import '../responses/base.response.dart';

@lazySingleton
class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<BaseResponse<SignInTokens?>> signIn(SignRequest request) async {
    final response = await apiClient.api.signIn(request.toMap());
    var newResponse = BaseResponse<SignInTokens?>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    final tokens = response.parse(SignInTokens.fromJson);
    newResponse.data = tokens;
    return newResponse;
  }

  Future<BaseResponse<SignInTokens?>> googleSignIn(
      GoogleSignInRequest request) async {
    final response = await apiClient.api.googleSignIn(request.toMap());
    var newResponse = BaseResponse<SignInTokens?>(
      code: response.code,
      success: response.success,
      data: null,
      error: response.error,
    );
    if (response.success == false) {
      return newResponse;
    }
    final tokens = response.parse(SignInTokens.fromJson);
    newResponse.data = tokens;
    return newResponse;
  }

  Future<BaseResponse> signUp(SignRequest request) async {
    final response = await apiClient.api.signUp(request.toMap());
    return response;
  }
}
