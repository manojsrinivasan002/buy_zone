import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final String thumbnail;
  @HiveField(6)
  final double discountPercentage;
  @HiveField(7)
  final double rating;
  @HiveField(8)
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.thumbnail,
    required this.discountPercentage,
    required this.rating,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] != null ? (json['id'] as num).toInt() : 0,
      title: json['title']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
      category: json['category']?.toString() ?? "",
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      thumbnail: json['thumbnail']?.toString() ?? "",
      discountPercentage: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num).toDouble()
          : 0.0,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['price'] = price;
    map['thumbnail'] = thumbnail;
    map['discountPercentage'] = discountPercentage;
    map['rating'] = rating;
    map['images'] = images;
    return map;
  }
}
