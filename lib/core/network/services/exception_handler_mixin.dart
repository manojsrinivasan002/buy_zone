import 'dart:developer';
import 'dart:io';
import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../models/response.dart' as response;
import 'network_service.dart';
import 'package:dio/dio.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.Response>> handleException(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    // Check for internet connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      log("No internet");
      return Left(
        AppException(
          message: "No internet connection",
          statusCode: 0,
          identifier: 'No Internet at $endpoint',
        ),
      );
    }

    try {
      Response<dynamic> res = await handler();
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          message: res.statusMessage,
        ),
      );
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;

      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          log("Unauthorized - Session expired...${e.response?.statusCode}");
          return Left(
            AppException(
              message: "Session expired",
              statusCode: 401,
              identifier: 'Unauthorized at $endpoint',
            ),
          );
        }

        message = e.response?.data?['message'] ?? 'Internal Error occurred';
        statusCode = e.response?.statusCode ?? 1;
        identifier = 'DioException ${e.message} at $endpoint';
      } else if (e is SocketException) {
        message = 'Unable to connect to the server.';
        statusCode = 0;
        identifier = 'Socket Exception ${e.message} at $endpoint';
      } else {
        message = 'Unknown error occurred';
        statusCode = 2;
        identifier = 'Unknown error ${e.toString()} at $endpoint';
      }

      return Left(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
