import 'dart:convert';

class RegisterResponseModel {
  final Data data;
  final String message;
  final int status;

  RegisterResponseModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
  final User user;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "user": user.toMap(),
      };
}

class User {
  final String email;
  final int id;
  final String name;

  User({
    required this.email,
    required this.id,
    required this.name,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "id": id,
        "name": name,
      };
}
