import 'package:buy_zone/features/home/data/models/product.dart';

abstract class HiveStorageService {
  Future<List<Product>> loadProducts();

  Future<void> addProduct(Product product);

  Future<void> updateProduct(int index, Product product);

  Future<void> removeProduct(int index);
}
