import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'profile.api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) = _ProfileApi;

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.PROFILE_ENDPOINT)
  Future<BaseResponse> createProfile(@Body() Map<String, dynamic> body);

  @GET(Constants.API_HOST + Constants.API_PREFIX + Constants.PROFILE_ENDPOINT)
  Future<BaseResponse> getProfile();

  @GET(Constants.API_HOST +
      Constants.API_PREFIX +
      Constants.MOST_FOLLOWED_PROFILE_ENDPOINT)
  Future<BaseResponse> getMostFollowedProfiles(
      @Query('page') int page, @Query('size') int size);

  @GET(
      '${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FOLLOWING_USERS_ENDPOINT}/{profileId}')
  Future<BaseResponse> getFollowingUsers(
    @Query("page") int page,
    @Query("size") int limit,
    @Path('profileId') String profileId,
  );

  @GET(
      '${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FOLLOWER_USERS_ENDPOINT}/{profileId}')
  Future<BaseResponse> getFollowerUsers(
    @Query("page") int page,
    @Query("size") int limit,
    @Path('profileId') String profileId,
  );
}
