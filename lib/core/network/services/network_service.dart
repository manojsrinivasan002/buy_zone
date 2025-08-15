import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/core/network/models/response.dart';
import 'package:dartz/dartz.dart';

abstract class NetworkService {
  String get baseUrl;
  Map<String, dynamic> get headers;
  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, Response>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });
}
