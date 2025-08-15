import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/core/network/models/response.dart';
import 'package:buy_zone/features/home/data/datasource/product_ds.dart';
import 'package:buy_zone/features/home/data/models/cat_res.dart';
import 'package:buy_zone/features/home/data/models/product_res.dart';
import 'package:buy_zone/features/home/domain/repo%20ab/product_repo_ab.dart';
import 'package:dartz/dartz.dart';

class ProductRepoImp extends ProductRepoAb {
  final ProductDs productDs;

  ProductRepoImp(this.productDs);

  @override
  Future<Either<AppException, ProductRes>> fetchProducts() async {
    return productDs.fetchProducts();
  }

  @override
  Future<Either<AppException, CatRes>> fetchCategories() {
    return productDs.fetchCategories();
  }

  @override
  Future<Either<ApiException, ApiResponse>> fetchCategories() {
    return productDs.fetchCategories(ApiConstants.categoriesEndPoint);
  }
}
