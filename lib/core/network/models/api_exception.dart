import 'package:dio/dio.dart';

class ApiException {
  final int? statusCode;
  final String errorMsg;

  ApiException({this.statusCode, required this.errorMsg});

  factory ApiException.fromDioError(DioException error) {
    return ApiException(
      errorMsg: error.message ?? "Unexpected error occurred",
      statusCode: error.response?.statusCode,
    );
  }
}
