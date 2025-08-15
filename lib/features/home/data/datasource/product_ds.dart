import 'package:buy_zone/core/network/constants/api_constants.dart';
import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/core/network/services/api_client.dart';
import 'package:buy_zone/features/home/data/models/cat_res.dart';
import 'package:buy_zone/features/home/data/models/product_res.dart';
import 'package:dartz/dartz.dart';

abstract class ProductDsAb {
  Future<Either<AppException, ProductRes>> fetchProducts();
  Future<Either<AppException, CatRes>> fetchCategories();
}

class ProductDs extends ProductDsAb {
  final ApiClient apiClient;

  ProductDs(this.apiClient);

  @override
  Future<Either<AppException, ProductRes>> fetchProducts() async {
    try {
      Either eitherType = await apiClient.get(ApiConstants.endPoint);
      return eitherType.fold(
        (exception) => Left(exception),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nProductDs.fetchProducts',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, CatRes>> fetchCategories() async {
    try {
      Either eitherType = await apiClient.get(ApiConstants.categoriesEndPoint);
      return eitherType.fold(
        (exception) => Left(exception),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nProductDs.fetchCategories',
        ),
      );
    }
  }
}
