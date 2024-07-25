import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:itunes_app/src/core/security/app_ssl_pinning.dart';

class DioHelper {
  static final DioHelper instance = DioHelper._internal();

  factory DioHelper() {
    instance.dio.interceptors.add(LoggingInterceptor());

    return instance;
  }

  DioHelper._internal();

  static Future<DioHelper> getInstance() async {
    final httpClient = await createSecureHttpClient();
    final dio = instance.dio;
    dio.httpClientAdapter =
        IOHttpClientAdapter(createHttpClient: () => httpClient);
    return instance;
  }

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
    debugPrint('REQUEST => ${options.uri}');

    super.onRequest(options, handler);
  }
}
