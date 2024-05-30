import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/util/constants.dart';
import '../../../domain/responses/base.response.dart';

part 'post.api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio) = _PostApi;

  @GET(Constants.API_HOST + Constants.API_PREFIX + Constants.POST_ENDPOINT)
  Future<BaseResponse> getRecentPosts(
    @Query("page") int page,
    @Query("size") int limit,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.POST_ENDPOINT}/{topicId}")
  Future<BaseResponse> getRecentPostsByTopic(
    @Query("page") int page,
    @Query("size") int limit,
    @Path("topicId") String topicId,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.POST_SEARCH_ENDPOINT}/{searchTopic}")
  Future<BaseResponse> searchPostsByTopic(
    @Query("page") int page,
    @Query("size") int limit,
    @Path("searchTopic") String searchTopic,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FAVORITE_POST_ENDPOINT}")
  Future<BaseResponse> getFavoritePost(
    @Query("page") int page,
    @Query("size") int limit,
  );

  @POST(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FAVORITE_POST_ENDPOINT_2}/{postId}")
  Future<BaseResponse> addFavoritePost(
    @Path("postId") String postId,
  );

  @DELETE(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.FAVORITE_POST_ENDPOINT_2}/{postId}")
  Future<BaseResponse> removeFavoritePost(
    @Path("postId") String postId,
  );

  @POST(Constants.API_HOST + Constants.API_PREFIX + Constants.POST_ENDPOINT)
  @MultiPart()
  Future<BaseResponse> createPost(
    @Part() File content,
    @Part() File thumbnail,
    @Part() String title,
    @Part() String description,
    @Part() List<String> topicIds,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.POST_LIKE_ENDPOINT}/{postId}")
  Future<BaseResponse> getPostLikes(
    @Path("postId") String postId,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.COMMENT_ENDPOINT}")
  Future<BaseResponse> getPostComments(
    @Query("postId") String postId,
  );

  @GET(
      "${Constants.API_HOST}${Constants.API_PREFIX}${Constants.POST_AUTHOR_ENDPOINT}/{authorId}")
  Future<BaseResponse> getPostsByAuthor(
    @Query("page") int page,
    @Query("size") int limit,
    @Path("authorId") String authorId,
  );
}
