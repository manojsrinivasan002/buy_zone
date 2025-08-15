import 'package:buy_zone/core/network/models/api_exception.dart';
import 'package:buy_zone/core/network/models/api_response.dart';
import 'package:buy_zone/features/home/domain/repo%20ab/product_repo_ab.dart';
import 'package:dartz/dartz.dart';

class ProductUseCase {
  final ProductRepoAb productRepoAb;

  ProductUseCase(this.productRepoAb);

  Future<Either<ApiException, ApiResponse>> execute() async {
    return productRepoAb.fetchProducts();
  }
}
