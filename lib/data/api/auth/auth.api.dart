import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.REGISTER_ENDPOINT)
  Future<BaseResponse> signUp(@Body() Map<String, dynamic> body);

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.LOGIN_ENDPOINT)
  Future<BaseResponse> signIn(@Body() Map<String, dynamic> body);

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.GOOGLE_LOGIN_ENDPOINT)
  Future<BaseResponse> googleSignIn(@Body() Map<String, dynamic> body);
}