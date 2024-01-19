import 'dart:convert';

class RegisterRequestModel {
  final String name;
  final String? phoneNumber;
  final String email;
  final String dob;
  final String gender;
  final String province;
  final String city;
  final String pin;
  final String platform;
  final String firebaseToken;
  final int otpId;
  final String deviceId;
  String? referalCode;

  RegisterRequestModel({
    required this.name,
    this.phoneNumber,
    required this.email,
    required this.dob,
    required this.gender,
    required this.province,
    required this.city,
    required this.pin,
    required this.platform,
    required this.firebaseToken,
    required this.otpId,
    required this.deviceId,
    this.referalCode,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "dob": dob,
      "gender": gender,
      "province": province,
      "city": city,
      "pin": pin,
      "platform": platform,
      "otp_id": otpId,
      "firebase_token": firebaseToken,
      "device_id": deviceId,
      "referal_code": referalCode,
    };

    if (phoneNumber != null) {
      map["phone_number"] = phoneNumber;
    }

    return map;
  }

  factory RegisterRequestModel.fromMap(Map<String, dynamic> map) {
    return RegisterRequestModel(
      name: map["name"],
      phoneNumber: map["phone_number"],
      dob: map["dob"],
      gender: map["gender"],
      platform: map["platform"],
      firebaseToken: map["firebase_token"],
      otpId: map["otp_id"],
      deviceId: map["device_id"],
      email: map["email"],
      province: map["province"],
      city: map["city"],
      pin: map["pin"],
      referalCode: map["referal_code"],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromJson(String source) =>
      RegisterRequestModel.fromMap(json.decode(source));
}
