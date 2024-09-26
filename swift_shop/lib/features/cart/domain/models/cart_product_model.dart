import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:swift_shop/core/extensions/string_extensions.dart';

class CartProductModel extends Equatable {
  const CartProductModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    this.selectedSize,
    this.selectedColour,
    required this.productExists,
    required this.productOutOfStock,
  });

  const CartProductModel.empty()
      : id = "Test String",
        productId = "Test String",
        quantity = 1,
        productName = "Test String",
        productImage = "Test String",
        productPrice = 1,
        selectedSize = null,
        selectedColour = null,
        productExists = true,
        productOutOfStock = true;

  final String id;
  final String productId;
  final int quantity;
  final String productName;
  final String productImage;
  final double productPrice;
  final String? selectedSize;
  final Color? selectedColour;
  final bool productExists;
  final bool productOutOfStock;

  @override
  List<dynamic> get props => [
    id,
    productId,
    quantity,
    productName,
    productImage,
    productPrice,
    selectedSize,
    selectedColour,
    productExists,
    productOutOfStock,
  ];

  // fromJson method to deserialize JSON into CartProductModel
  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'] as String,
      productId: json['product'] as String,
      quantity: json['quantity'] as int,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      selectedSize: json['selectedSize'] as String?,
      selectedColour: (json['selectedColour'] as String?)?.colour,
      productExists: json['productExists'] as bool,
      productOutOfStock: json['productOutOfStock'] as bool,
    );
  }

  // copyWith method to create a modified copy of CartProductModel
  CartProductModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    String? productName,
    String? productImage,
    double? productPrice,
    String? selectedSize,
    Color? selectedColour,
    bool? productExists,
    bool? productOutOfStock,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productPrice: productPrice ?? this.productPrice,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColour: selectedColour ?? this.selectedColour,
      productExists: productExists ?? this.productExists,
      productOutOfStock: productOutOfStock ?? this.productOutOfStock,
    );
  }
}
