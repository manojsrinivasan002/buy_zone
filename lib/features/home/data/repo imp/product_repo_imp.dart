import 'package:buy_zone/core/network/constants/api_constants.dart';
import 'package:buy_zone/core/network/models/api_exception.dart';
import 'package:buy_zone/core/network/models/api_response.dart';
import 'package:buy_zone/features/home/data/datasource/product_ds.dart';
import 'package:buy_zone/features/home/domain/repo%20ab/product_repo_ab.dart';
import 'package:dartz/dartz.dart';

class ProductRepoImp extends ProductRepoAb {
  final ProductDs productDs;

  ProductRepoImp(this.productDs);

  @override
  Future<Either<ApiException, ApiResponse>> fetchProducts() async {
    return productDs.fetchProducts(ApiConstants.endPoint);
  }
}
