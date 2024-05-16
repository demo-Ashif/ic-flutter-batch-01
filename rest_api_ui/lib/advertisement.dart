class Advertisement {
  int? id;
  String? title;
  String? thumbnail;
  String? price;
  bool? featured;
  String? category;

  Advertisement({
    this.id,
    this.title,
    this.thumbnail,
    this.price,
    this.featured,
    this.category,
  });

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    price = json['price'];
    featured = json['featured'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['featured'] = featured;
    data['category'] = category;
    return data;
  }
}
