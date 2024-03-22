import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'follow.api.g.dart';

@RestApi()
abstract class FollowApi {
  factory FollowApi(Dio dio) = _FollowApi;

  @POST('${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FOLLOW_ENDPOINT}/{id}')
  Future<BaseResponse> follow(@Path('id') String id, @Body() Map<String, dynamic> body);

  @POST('${Constants.API_HOST}${Constants.API_PREFIX}${Constants.UNFOLLOW_ENDPOINT}/{id}')
  Future<BaseResponse> unfollow(@Path('id') String id, @Body() Map<String, dynamic> body);

  @POST('${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FOLLOW_ENDPOINT}')
  Future<BaseResponse> followMultiple(@Body() Map<String, dynamic> body);
}