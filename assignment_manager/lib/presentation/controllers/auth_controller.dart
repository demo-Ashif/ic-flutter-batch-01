import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class AuthController {
  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('userModel', jsonEncode(userModel.toJson()));
    AuthController.userModel = userModel;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = sharedPreferences.getString('userModel');
    if (result == null) {
      return null;
    }
    final user =  UserModel.fromJson(jsonDecode(result));
    AuthController.userModel = user;
    return user;
  }

  static Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    accessToken = token;
  }

  static Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  static Future<bool> isUserLoggedIn() async {
    final result = await getUserToken();
    accessToken = result;
    bool loginState = result != null;
    if (loginState) {
      await getUserData();
    }
    return loginState;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}