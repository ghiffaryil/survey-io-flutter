import 'dart:convert';

class AuthGuestResponseModel {
  final Data data;
  final String message;
  final int status;

  AuthGuestResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AuthGuestResponseModel.fromJson(String str) =>
      AuthGuestResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthGuestResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthGuestResponseModel(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "message": message,
        "status": status,
      };
}

class Data {
  final String accessToken;
  final String refreshToken;

  Data({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
