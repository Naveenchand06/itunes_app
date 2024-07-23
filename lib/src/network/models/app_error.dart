class AppErrorModel {
  final int statusCode;
  final String errorMessage;

  const AppErrorModel({
    this.statusCode = 0,
    this.errorMessage = '',
  });

  const AppErrorModel.unknown()
      : statusCode = 0,
        errorMessage = '';

  AppErrorModel copyWith({
    int? statusCode,
    String? errorMessage,
  }) =>
      AppErrorModel(
        statusCode: statusCode ?? this.statusCode,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
