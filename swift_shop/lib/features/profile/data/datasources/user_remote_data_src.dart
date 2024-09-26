// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../core/app/cache/cache_helper.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/errors/error_reponse.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants/network_constants.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/typedefs.dart';
import '../../domain/models/user_model.dart';

import 'package:swift_shop/core/extensions/string_extensions.dart';

abstract class UserRemoteDataSrc {
  Future<UserModel> getUser(String userId);

  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  });
}

const GET_USER_ENDPOINT = '/users';
const UPDATE_USER_ENDPOINT = '/users';

class UserRemoteDataSrcImpl implements UserRemoteDataSrc {
  const UserRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$GET_USER_ENDPOINT/$userId',
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
      return UserModel.fromMap(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserModel> updateUser({
    required String userId,
    required DataMap updateData,
  }) async {
    try {
      final uri = Uri.parse(
        '${NetworkConstants.baseUrl}$UPDATE_USER_ENDPOINT/$userId',
      );

      final response = await _client.put(
        uri,
        body: jsonEncode(updateData),
        headers: sl<CacheHelper>().getAccessToken()?.toHeaders,
      );
      final payload = jsonDecode(response.body) as DataMap;
      await NetworkUtils.renewToken(response);
      if (response.statusCode != 200 && response.statusCode != 201) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerException(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      return UserModel.fromMap(payload);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
