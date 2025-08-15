import 'package:buy_zone/core/network/models/api_exception.dart';
import 'package:buy_zone/core/network/models/api_response.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepoAb {
  Future<Either<ApiException, ApiResponse>> fetchProducts();
}
