import 'package:buy_zone/core/network/models/app_exception.dart';
import 'package:buy_zone/core/network/models/response.dart';
import 'package:buy_zone/features/home/data/models/cat_res.dart';
import 'package:buy_zone/features/home/data/models/product_res.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepoAb {
  Future<Either<AppException, ProductRes>> fetchProducts();
  Future<Either<AppException, CatRes>> fetchCategories();
}
