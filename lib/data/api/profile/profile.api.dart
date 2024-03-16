import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'profile.api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.CREATE_PROFILE_ENDPOINT)
  Future<BaseResponse> createProfile(@Body() Map<String, dynamic> body);
}