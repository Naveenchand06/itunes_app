import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_strings.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:itunes_app/src/features/services/search_service.dart';
import 'package:itunes_app/src/network/models/app_error.dart';
import 'package:itunes_app/src/network/models/app_response.dart';

// * ================ Search Notifier Provider =======================

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, AppResponse<SearchResponse>>((ref) {
  return SearchNotifier();
});

// * ================ Search Notifier =======================

class SearchNotifier extends StateNotifier<AppResponse<SearchResponse>> {
  SearchNotifier() : super(const AppResponse.unknown());
  final _searchService = SearchService();

  Future search({
    required String term,
    String tag = '',
    int limit = 20,
  }) async {
    state = state.showLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    try {
      final Response res =
          await _searchService.search(term: term, tag: tag, limit: limit);
      final decoded = (jsonDecode(res.data) as Map<String, dynamic>);
      final allResponse = AllSearchResponse.fromJson(decoded);
      final searchResponse = SearchResponse(
          resultCount: allResponse.resultCount, categoryResults: []);

      final groupedModels = groupBy(allResponse.results, (model) => model.kind);

      for (final type in AppStrings.mediaTypes) {
        searchResponse.categoryResults.add(
            CategoryResult(category: type, results: groupedModels[type] ?? []));
      }

      state = state.copyWith(
        result: searchResponse,
        isLoading: false,
        error: null,
      );
    } catch (e, stack) {
      log('Search error iss --> $stack');

      log('Search error is --> $e');
      state = state.copyWith(
          isLoading: false,
          error: const AppErrorModel(
              statusCode: 500, errorMessage: "Something went wrong!"));
    }
  }
}
