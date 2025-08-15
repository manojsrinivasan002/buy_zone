import 'package:buy_zone/core/network/models/api_exception.dart';
import 'package:buy_zone/core/network/models/api_response.dart';
import 'package:buy_zone/core/network/services/api_client.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDsAb {
  Future<Either<ApiException, ApiResponse>> fetchProducts(String endPoint);
  Future<Either<ApiException, ApiResponse>> fetchCategories(String endPoint);
}

class ProductDs extends ProductDsAb {
  final ApiClient apiClient;

  ProductDs(this.apiClient);

  @override
  Future<Either<ApiException, ApiResponse>> fetchProducts(
    String endPoint,
  ) async {
    final result = await apiClient.get(endPoint);
    return result.fold(
      (exception) => Left(exception),
      (response) => Right(
        ApiResponse(
          statusCode: response.statusCode,
          message: response.message,
          data: response.data,
        ),
      ),
    );
  }

  @override
  Future<Either<ApiException, ApiResponse>> fetchCategories(
    String endPoint,
  ) async {
    final result = await apiClient.get(endPoint);
    return result.fold(
      (exception) => Left(exception),
      (response) => Right(
        ApiResponse(
          statusCode: response.statusCode,
          message: response.message,
          data: response.data,
        ),
      ),
    );
  }
}
