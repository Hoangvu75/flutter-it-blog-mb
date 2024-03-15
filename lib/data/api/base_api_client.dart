import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/config/get_it.dart';
import '../../core/util/constants.dart';
import '../../infrastructure/services/storage.service.dart';

abstract class BaseApiClient {
  late final Dio dio;
  late final String baseURL;
  final localStorageService = getIt.get<StorageService>();

  BaseApiClient() {
    baseURL = Constants.API_HOST;
    dio = Dio();
    dio.options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      validateStatus: (_) => true,
      contentType: Headers.jsonContentType,
    );
    dio.interceptors
      ..add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          responseBody: true,
          error: true,
        ),
      )
      ..add(
        InterceptorsWrapper(
          onRequest: (
            RequestOptions options,
            RequestInterceptorHandler handler,
          ) async {
            final token = await localStorageService.getToken();
            if (token != null) {
              options.headers['Authorization'] = "Bearer $token";
            }
            handler.next(options);
          },
          onError: (
            DioException exception,
            ErrorInterceptorHandler handler,
          ) {
            throw exception;
          },
        ),
      );
  }
}
