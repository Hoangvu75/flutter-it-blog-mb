import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'post.api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @GET(Constants.API_HOST + Constants.API_PREFIX + Constants.POST_ENDPOINT)
  Future<BaseResponse> getRecentPosts();
}