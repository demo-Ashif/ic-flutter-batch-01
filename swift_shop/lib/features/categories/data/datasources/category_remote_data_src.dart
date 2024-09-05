// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:swift_shop/core/app/cache/cache_helper.dart';
import 'package:swift_shop/core/extensions/string_extensions.dart';
import 'package:swift_shop/features/products/domain/product_category.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/errors/error_reponse.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/network_constants.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/typedefs.dart';

abstract class CategoryRemoteDataSrc {
  const CategoryRemoteDataSrc();

  Future<List<ProductCategoryModel>> getCategories();
}

const getCategoryEndpoint = '/categories';

class CategoryRemoteDataSrcImpl implements CategoryRemoteDataSrc {
  const CategoryRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<ProductCategoryModel>> getCategories() async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$getCategoryEndpoint',
      );

      final response = await _client.get(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
      );
      final payload = jsonDecode(response.body);
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        payload as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      payload as List<dynamic>;
      return payload
          .cast<DataMap>()
          .map((category) => ProductCategoryModel.fromJson(category))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
