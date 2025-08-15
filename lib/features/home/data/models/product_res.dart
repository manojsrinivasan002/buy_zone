import 'dart:convert';
import 'product.dart';

ProductRes productResFromJson(String str) {
  return ProductRes.fromJson(json.decode(str));
}

String productResToJson(ProductRes data) {
  return json.encode(data.toJson());
}

class ProductRes {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductRes({this.products, this.total, this.skip, this.limit});

  ProductRes.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products!.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}
