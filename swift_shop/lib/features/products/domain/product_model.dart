import 'package:flutter/material.dart';
import 'package:swift_shop/core/extensions/string_extensions.dart';
import 'package:swift_shop/features/products/domain/product_category.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final List<Color> colours;
  final String image;
  final List<String> images;
  final List<String> reviewIds;
  final int numberOfReviews;
  final List<String> sizes;
  final ProductCategoryModel category;
  final String? genderAgeCategory;
  final int countInStock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.colours,
    required this.image,
    required this.images,
    required this.reviewIds,
    required this.numberOfReviews,
    required this.sizes,
    required this.category,
    this.genderAgeCategory,
    required this.countInStock,
  });

  const ProductModel.empty()
      : id = "id_001",
        name = "Test Name",
        description = "Test String",
        price = 1,
        rating = 1,
        colours = const [
          Color(0xffb52ca9),
          Color(0xff1ac933),
          Color(0xfff8dc85)
        ],
        image = "https://images.unsplash.com/photo-1519554318711-aaf73ece6ff9",
        images = const [],
        reviewIds = const [],
        numberOfReviews = 1,
        sizes = const [
          'S','M','XL','XXL'
        ],
        category = const ProductCategoryModel.empty(),
        genderAgeCategory = "Test String",
        countInStock = 1;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final colours = json['colours'] as List<dynamic>?;
    final images = json['images'] as List<dynamic>?;
    final reviewIds = json['reviewIds'] as List<dynamic>?;
    final sizes = json['sizes'] as List<dynamic>?;
    final category = json['category'];

    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      colours: colours == null
          ? []
          : List<String>.from(colours).map((hex) => hex.colour).toList(),
      image: json['image'] as String,
      images: images == null ? [] : List<String>.from(images),
      reviewIds: reviewIds == null ? [] : List<String>.from(reviewIds),
      numberOfReviews: (json['numberOfReviews'] as num).toInt(),
      sizes: sizes == null ? [] : List<String>.from(sizes),
      category: category is String
          ? ProductCategoryModel(id: category)
          : ProductCategoryModel.fromJson(category),
      genderAgeCategory: json['genderAgeCategory'] as String?,
      countInStock: (json['countInStock'] as num).toInt(),
    );
  }
}
