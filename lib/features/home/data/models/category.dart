class Category {
  String slug;
  String name;
  String url;

  Category({required this.slug, required this.name, required this.url});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      slug: json['slug']?.toString() ?? "No slug",
      name: json['name']?.toString() ?? "No name",
      url: json['url']?.toString() ?? "No url",
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'slug': slug, 'url': url};
  }
}
