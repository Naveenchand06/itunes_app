import 'package:dio/dio.dart';
import 'package:itunes_app/src/core/network/dio_helper.dart';

class SearchService {
  Future<Response> search({
    required String term,
    required String tag,
    required int limit,
  }) async {
    try {
      final dio = await DioHelper.getInstance();
      final response = await dio.dio.get(
        "/search?term=$term&entity=$tag&limit=$limit",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
