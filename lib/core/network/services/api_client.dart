import 'package:buy_zone/core/network/constants/api_constants.dart';
import 'package:buy_zone/core/network/models/api_exception.dart';
import 'package:buy_zone/core/network/models/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class ApiClient {
  late final Dio _dio;

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        baseUrl: ApiConstants.baseUrl,
        headers: ApiConstants.defaultHeaders,
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          queryParameters: true,
          error: true,
          showProcessingTime: true,
          showCUrl: true,
          canShowLog: true,
        ),
      );
    }
  }

  Future<Either<ApiException, ApiResponse>> get(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endPoint, queryParameters: queryParams);
      return Right(
        ApiResponse(
          statusCode: response.statusCode!,
          data: response.data,
          message: response.statusMessage,
        ),
      );
    } on DioException catch (e) {
      return Left(ApiException.fromDioError(e));
    } catch (e) {
      return Left(ApiException(errorMsg: "Unknown error occurred: $e"));
    }
  }
}
