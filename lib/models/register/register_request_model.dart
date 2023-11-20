import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String email;
  final String dob;
  final String gender;
  final String province;
  final String city;
  final int pin;
  final String platform;
  final String firebaseToken;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.dob,
    required this.gender,
    required this.province,
    required this.city,
    required this.pin,
    required this.platform,
    required this.firebaseToken,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "dob": dob,
      "gender": gender,
      "province": province,
      "city": city,
      "pin": pin,
      "platform": platform,
      "firebaseToken": firebaseToken,
    };
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map["name"],
      email: map["email"],
      dob: map["dob"],
      gender: map["gender"],
      province: map["province"],
      city: map["city"],
      pin: map["pin"],
      platform: map["platform"],
      firebaseToken: map["firebase_token"],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.toJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source));
}
