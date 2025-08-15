import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/features/home/data/models/cat_res.dart';
import 'package:buy_zone/features/home/data/models/product_res.dart';
import 'package:buy_zone/features/home/domain/repo%20ab/product_repo_ab.dart';
import 'package:dartz/dartz.dart';

class ProductUseCase {
  final ProductRepoAb productRepoAb;

  const ProductUseCase(this.productRepoAb);

  Future<Either<AppException, ProductRes>> fetchProducts() async {
    return productRepoAb.fetchProducts();
  }

  Future<Either<AppException, CatRes>> fetchCategories() async {
    return productRepoAb.fetchCategories();
  }
}
