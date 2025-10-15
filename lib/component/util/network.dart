import 'dart:io';

import 'package:dio/dio.dart';

class Network {
  static Dio dioClient() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 40),
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
    dio.interceptors.add(AuthorizationInterceptor());
    dio.interceptors.add(NoInternetInterceptor(dio));
    return dio;
  }
}

class UnauthorizedException implements Exception {}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';

    handler.next(options); // continue with the request
  }
}

class NoInternetInterceptor extends Interceptor {
  final Dio dio;

  NoInternetInterceptor(
    this.dio,
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if ((err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.unknown) &&
        err.error is SocketException) {}

    super.onError(err, handler);
  }
}
