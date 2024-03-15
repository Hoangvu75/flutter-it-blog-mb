import 'package:injectable/injectable.dart';

import '../../data/api/auth/auth.api_client.dart';
import '../entities/sign_in_tokens.dart';
import '../requests/google_sign_in.request.dart';
import '../requests/sign.request.dart';
import '../responses/base.response.dart';

@lazySingleton
class AuthRepository {
  final AuthApiClient apiClient = AuthApiClient();

  Future<SignInTokens> signIn(SignRequest request) async {
    final response = await apiClient.api.signIn(request.toMap());
    SignInTokens tokens = response.parse(SignInTokens.fromJson);
    return tokens;
  }

  Future<SignInTokens> googleSignIn(GoogleSignInRequest request) async {
    final response = await apiClient.api.googleSignIn(request.toMap());
    SignInTokens tokens = response.parse(SignInTokens.fromJson);
    return tokens;
  }

  Future<BaseResponse> signUp(SignRequest request) async {
    final response = await apiClient.api.signUp(request.toMap());
    return response;
  }
}
