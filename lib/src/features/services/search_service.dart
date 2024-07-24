import 'package:dio/dio.dart';
import 'package:itunes_app/src/network/dio_helper.dart';

class SearchService {
  Future<Response> search({
    required String term,
    required String tag,
    required int limit,
  }) async {
    try {
      DioHelper().dio.interceptors.add(LoggingInterceptor());
      final response = await DioHelper().dio.get(
            "/search?term=$term&entity=$tag&limit=$limit",
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
