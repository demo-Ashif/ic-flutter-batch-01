import 'package:swift_shop/core/app/cache/cache_helper.dart';

class Cache {
  Cache._internal();


  static final Cache instance = Cache._internal();

  String? _sessionToken;
  String? _userId;

  String? get sessionToken => _sessionToken;
  String? get userId => _userId;

  void setSessionToken(String? newToken) {
    if (_sessionToken != newToken) _sessionToken = newToken;
  }

  void setUserId(String? userId) {
    if (_userId != userId) _userId = userId;
  }

  void resetSession() {
    setSessionToken(null);
    setUserId(null);
  }
}
