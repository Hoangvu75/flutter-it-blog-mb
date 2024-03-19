import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'topic.api.g.dart';

@RestApi()
abstract class TopicApi {
  factory TopicApi(Dio dio) = _TopicApi;

  @GET(Constants.API_HOST + Constants.API_PREFIX + Constants.TOPIC_ENDPOINT)
  Future<BaseResponse> getTopics();

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.SET_TOPIC_ENDPOINT)
  Future<BaseResponse> setTopics(@Body() Map<String, dynamic> body);
}