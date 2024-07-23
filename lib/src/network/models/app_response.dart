import 'package:itunes_app/src/network/models/app_error.dart';

class AppResponse<T> {
  final T? result;
  final bool isLoading;
  final AppErrorModel? error;

  const AppResponse({
    this.result,
    this.isLoading = false,
    this.error,
  });

  const AppResponse.unknown()
      : result = null,
        isLoading = false,
        error = null;

  AppResponse<T> showLoading(bool isLoading) => AppResponse(
        result: result,
        isLoading: isLoading,
        error: error,
      );

  AppResponse<T> copyWith({
    T? result,
    bool? isLoading,
    AppErrorModel? error,
  }) =>
      AppResponse(
        result: result ?? this.result,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}
