import 'dart:convert';

class UpdateProfileRequestModel {
  final int id;
  final String name;
  final String email;
  final int emailVerified;
  final int active;
  final String phoneNumber;
  final String provider;
  final String dob;
  final dynamic age;
  final String gender;
  final String province;
  final String city;
  final String platform;
  final String firebaseToken;
  final String datetimeCreated;
  final String datetimeUpdated;

  UpdateProfileRequestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.active,
    required this.phoneNumber,
    required this.provider,
    required this.dob,
    required this.age,
    required this.gender,
    required this.province,
    required this.city,
    required this.platform,
    required this.firebaseToken,
    required this.datetimeCreated,
    required this.datetimeUpdated
  });

  factory UpdateProfileRequestModel.fromJson(String str) =>
      UpdateProfileRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateProfileRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateProfileRequestModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerified: json["email_verified"],
        active: json["active"],
        phoneNumber: json["phone_number"],
        provider: json["provider"],
        dob: json["dob"],
        age: json["age"],
        gender: json["gender"],
        province: json["province"],
        city: json["city"],
        platform: json["platform"],
        firebaseToken: json["firebase_token"],
        datetimeCreated: json["datetime_created"],
        datetimeUpdated: json["datetime_updated"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified": emailVerified,
        "active": active,
        "phone_number": phoneNumber,
        "provider": provider,
        "dob": dob,
        "age": age,
        "gender": gender,
        "province": province,
        "city": city,
        "platform": platform,
        "firebase_token": firebaseToken,
        "datetime_created": datetimeCreated,
        "datetime_updated": datetimeUpdated,
      };
}
