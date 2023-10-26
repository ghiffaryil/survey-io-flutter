import 'dart:convert';

class AuthResponseModel {
  final String accessToken;
  final User user;

  AuthResponseModel({
    required this.accessToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        accessToken: json["data"]["access_token"],
        user: User.fromMap(json["data"]["user"]),
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "user": user.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final int emailVerified;
  final int active;
  final String refcode;
  final String platform;
  final String ktp;
  final String npwp;
  final int point;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.active,
    required this.refcode,
    required this.ktp,
    required this.npwp,
    required this.platform,
    required this.point,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerified: json["email_verified"],
        active: json["active"],
        refcode: json["refcode"],
        ktp: json["ktp"],
        npwp: json["npwp"],
        platform: json["platform"],
        point: json["point"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified": emailVerified,
        "active": active,
        "refcode": refcode,
        "ktp": ktp,
        "npwp": npwp,
        "platform": platform,
        "point": point,
      };
}
