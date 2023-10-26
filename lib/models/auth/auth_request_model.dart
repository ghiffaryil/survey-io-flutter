import 'dart:convert';

class AuthRequestModel {
  final String phoneNumber;
  final String pin;
  final String firebaseToken;
  final String platform;
  final String deviceId;

  AuthRequestModel({
    required this.phoneNumber,
    required this.pin,
    required this.firebaseToken,
    required this.platform,
    required this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone_number': phoneNumber,
      'pin': pin,
      'firebase_token': firebaseToken,
      'platform': platform,
      'device_id': deviceId,
    };
  }

  factory AuthRequestModel.fromMap(Map<String, dynamic> map) {
    return AuthRequestModel(
      phoneNumber: map['phone_number'] ?? '',
      pin: map['pin'] ?? '',
      firebaseToken: map['firebaseToken'] ?? '',
      platform: map['platform'] ?? '',
      deviceId: map['deviceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequestModel.toJson(String source) =>
      AuthRequestModel.fromMap(json.decode(source));
}
