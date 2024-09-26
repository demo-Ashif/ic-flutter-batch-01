import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:swift_shop/core/extensions/colour_extensions.dart';

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/errors/error_reponse.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/network_constants.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/models/cart_product_model.dart';
import 'package:swift_shop/core/extensions/string_extensions.dart';

abstract class CartRemoteDataSrc {
  Future<List<CartProductModel>> getCart(String userId);

  Future<int> getCartCount(String userId);

  Future<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  });

  Future<void> addToCart({
    required String userId,
    required CartProductModel cartProduct,
  });

  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  });

  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  });

  Future<String> initiateCheckout({
    required String theme,
    required List<CartProductModel> cartItems,
  });
}

class CartRemoteDataSrcImpl implements CartRemoteDataSrc {
  const CartRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<CartProductModel>> getCart(String userId) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}',
      );

      final response = await _client
          .get(
            uri,
            headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
          )
          .timeout(
            const Duration(seconds: 60),
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
          .map(
            (cartProduct) => CartProductModel.fromJson(cartProduct),
          )
          .toList();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<int> getCartCount(String userId) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/count',
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
      return (payload as num).toInt();
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<CartProductModel> getCartProduct({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/$cartProductId',
      );

      final response = await _client.get(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
      );
      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return CartProductModel.fromJson(payload);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> addToCart({
    required String userId,
    required CartProductModel cartProduct,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}',
      );

      final response = await _client.post(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
        body: jsonEncode({
          'productId': cartProduct.productId,
          'quantity': cartProduct.quantity,
          if (cartProduct.selectedSize != null)
            'selectedSize': cartProduct.selectedSize,
          if (cartProduct.selectedColour != null)
            'selectedColour': cartProduct.selectedColour!.hex,
        }),
      );
      await NetworkUtils.renewToken(response);

      // final payload = jsonDecode(response.body) as DataMap;
      debugPrint('Ashif payload: ${response.body.toString()}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> removeFromCart({
    required String userId,
    required String cartProductId,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}${_userCartEndpoint(userId)}/$cartProductId',
      );

      final response = await _client.delete(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
      );
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 204) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> changeCartProductQuantity({
    required String userId,
    required String cartProductId,
    required int newQuantity,
  }) async {
    try {
      final uri = Uri.parse(
        // NetworkConstants.authority,
        '${NetworkConstants.baseUrl}${_userCartEndpoint(userId)}/$cartProductId',
      );

      debugPrint(
          '${NetworkConstants.baseUrl}${_userCartEndpoint(userId)}/$cartProductId');

      final response = await _client.put(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
        body: jsonEncode({'quantity': newQuantity}),
      );
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> initiateCheckout({
    required String theme,
    required List<CartProductModel> cartItems,
  }) async {
    try {
      final uri = Uri.http(
        NetworkConstants.authority,
        '${NetworkConstants.apiUrl}/checkout',
        {'theme': theme},
      );

      final response = await _client.post(
        uri,
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
        body: jsonEncode({
          'cartItems': cartItems.map((cartProduct) {
            return {
              "name": cartProduct.productName,
              "images": [cartProduct.productImage],
              "price": cartProduct.productPrice,
              "productId": cartProduct.productId,
              "cartProductId": cartProduct.id,
              "quantity": cartProduct.quantity,
              if (cartProduct case CartProductModel(:final selectedSize))
                "selectedSize": selectedSize,
              if (cartProduct
                  case CartProductModel(:final Color selectedColour))
                "selectedColour": selectedColour.hex
            };
          }).toList(),
        }),
      );
      await NetworkUtils.renewToken(response);
      final payload = jsonDecode(response.body) as DataMap;
      if (response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return payload['url'] as String;
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  String _userCartEndpoint(String userId) => '/users/$userId/cart';
}
