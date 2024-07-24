import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    _instance.dio.interceptors.add(LoggingInterceptor());
    // _instance.dio.interceptors.add(
    //   CertificatePinningInterceptor(
    //     allowedSHAFingerprints: [
    //       "8317efefe33594d2b38a267bbfc690ed0e4a14a8bd44aa3efa9db1eecde19677"
    //     ],
    //   ),
    // );
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
