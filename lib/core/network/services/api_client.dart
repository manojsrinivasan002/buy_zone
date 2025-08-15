import 'package:buy_zone/core/network/constants/api_constants.dart';
import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/core/network/models/response.dart';
import 'package:buy_zone/core/network/services/exception_handler_mixin.dart';
import 'package:buy_zone/core/network/services/network_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' hide Response;
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class ApiClient extends NetworkService with ExceptionHandlerMixin {
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

  @override
  String get baseUrl => ApiConstants.baseUrl;

  @override
  Map<String, dynamic> get headers => ApiConstants.defaultHeaders;

  @override
  void updateHeader(Map<String, dynamic> data) {
    Map<String, dynamic> header = {...data, ...headers};
    _dio.options.headers = header;
  }

  @override
  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return handleException(
      () => _dio.get(endpoint, queryParameters: queryParameters),
      endpoint: endpoint,
    );
  }
}
