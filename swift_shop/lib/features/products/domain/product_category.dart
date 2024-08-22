class ProductCategoryModel {
  final String id;
  final String? name;
  final String? colour;
  final String? image;

  const ProductCategoryModel({
    required this.id,
    this.name,
    this.colour,
    this.image,
  });

  const ProductCategoryModel.empty() : this(id: '001', name: 'Cat 1');

  ProductCategoryModel.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            name: json['name'],
            colour: json['colour'],
            image: json['image']);
}
