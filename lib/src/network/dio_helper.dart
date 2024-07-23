import 'dart:developer';

import 'package:dio/dio.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  DioHelper._internal();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://itunes.apple.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST => ${options.uri}');
    super.onRequest(options, handler);
  }
}
