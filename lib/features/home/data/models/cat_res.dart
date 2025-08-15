import 'dart:convert';
import 'category.dart';

CatRes categoryResponseFromJson(String str) =>
    CatRes.fromJson(json.decode(str));
String categoryResponseToJson(CatRes data) => json.encode(data.toJson());

class CatRes {
  CatRes({this.categories});

  CatRes.fromJson(dynamic json) {
    if (json != null) {
      categories = <Category>[];
      json.forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
  }

  List<Category>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
