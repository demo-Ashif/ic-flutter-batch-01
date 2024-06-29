import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool status;
  String message;
  String accessToken;
  String tokenType;

  LoginResponseModel({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });

  LoginResponseModel copyWith({
    bool? status,
    String? message,
    String? accessToken,
    String? tokenType,
  }) =>
      LoginResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "token_type": tokenType,
  };
}
