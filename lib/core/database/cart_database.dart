import 'package:buy_zone/core/database/hive_storage_service.dart';
import 'package:buy_zone/features/home/data/models/product.dart';
import 'package:hive/hive.dart';

class CartDatabase implements HiveStorageService {
  final _myBox = Hive.box("cart_db");

  @override
  Future<void> addProduct(Product product) async {
    await _myBox.add(product);
  }

  @override
  Future<List<Product>> loadProducts() async {
    return _myBox.values.toList().cast();
  }

  Future<void> removeProductById(int productId) async {
    final products = _myBox.values.toList().cast<Product>();
    for (int i = 0; i < products.length; i++) {
      if (products[i].id == productId) {
        await _myBox.deleteAt(i);
        break;
      }
    }
  }

  @override
  Future<void> removeProduct(int index) async {
    await _myBox.deleteAt(index);
  }

  @override
  Future<void> updateProduct(int index, Product product) async {
    await _myBox.putAt(index, product);
  }
}
