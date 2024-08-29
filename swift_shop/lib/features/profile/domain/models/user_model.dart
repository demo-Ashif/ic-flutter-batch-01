import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:swift_shop/features/profile/domain/models/address.dart';
import 'package:swift_shop/features/wishlist/domain/models/wishlist_product.dart';

import '../../../../core/utils/typedefs.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    required this.wishlist,
    this.address,
    this.phone,
  });

  const UserModel.empty()
      : id = "Test String",
        name = "Test String",
        email = "Test String",
        isAdmin = true,
        wishlist = const [],
        address = null,
        phone = null;

  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final List<WishlistProductModel> wishlist;
  final AddressModel? address;
  final String? phone;

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromMap(DataMap map) {
    final address = AddressModel.fromMap({
      if (map['street'] != null) 'street': map['street'],
      if (map['apartment'] != null) 'apartment': map['apartment'],
      if (map['city'] != null) 'city': map['city'],
      if (map['zip'] != null) 'zip': map['zip'],
      if (map['country'] != null) 'country': map['country'],
    });
    return UserModel(
      id: map['id'] as String? ?? map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      isAdmin: map['isAdmin'] as bool,
      wishlist: List<DataMap>.from(map['wishlist'] as List<dynamic>)
          .map(WishlistProductModel.fromMap)
          .toList(),
      address: address.isEmpty ? null : address,
      phone: map['phone'] as String?,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
    List<WishlistProductModel>? wishlist,
    AddressModel? address,
    String? phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      wishlist: wishlist ?? this.wishlist,
      address: address ?? this.address,
      phone: phone ?? this.phone,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isAdmin': isAdmin,
      'wishlist': wishlist
          .map(
            (product) => (product as WishlistProductModel).toMap(),
          )
          .toList(),
      if (address != null) 'address': (address as AddressModel).toMap(),
      if (phone != null) 'phone': phone
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<dynamic> get props => [
        id,
        name,
        email,
        isAdmin,
      ];
}
