import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../core/utils/typedefs.dart';

class AddressModel extends Equatable {
  const AddressModel({
    this.street,
    this.apartment,
    this.city,
    this.zip,
    this.country,
  });

  const AddressModel.empty()
      : street = "Test String",
        apartment = "Test String",
        city = "Test String",
        zip = "Test String",
        country = "Test String";

  final String? street;
  final String? apartment;
  final String? city;
  final String? zip;
  final String? country;

  bool get isEmpty =>
      street == null &&
      apartment == null &&
      city == null &&
      zip == null &&
      country == null;


  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(jsonDecode(source) as DataMap);

  AddressModel.fromMap(DataMap map)
      : this(
    street: map['street'] as String?,
    apartment: map['apartment'] as String?,
    city: map['city'] as String?,
    zip: map['zip'] as String?,
    country: map['country'] as String?,
  );

  AddressModel copyWith({
    String? street,
    String? apartment,
    String? city,
    String? zip,
    String? country,
  }) {
    return AddressModel(
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      country: country ?? this.country,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'street': street,
      'apartment': apartment,
      'city': city,
      'zip': zip,
      'country': country,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<dynamic> get props => [
        street,
        apartment,
        city,
        zip,
        country,
      ];
}
