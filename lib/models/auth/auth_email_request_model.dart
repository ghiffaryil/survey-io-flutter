import 'dart:convert';

class AuthEmailRequestModel {
  final String email;
  final String pin;
  final String firebaseToken;
  final String platform;
  final String deviceId;

  AuthEmailRequestModel({
    required this.email,
    required this.pin,
    required this.firebaseToken,
    required this.platform,
    required this.deviceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'pin': pin,
      'firebase_token': firebaseToken,
      'platform': platform,
      'device_id': deviceId,
    };
  }

  factory AuthEmailRequestModel.fromMap(Map<String, dynamic> map) {
    return AuthEmailRequestModel(
      email: map['email'] ?? '',
      pin: map['pin'] ?? '',
      firebaseToken: map['firebaseToken'] ?? '',
      platform: map['platform'] ?? '',
      deviceId: map['deviceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthEmailRequestModel.toJson(String source) =>
      AuthEmailRequestModel.fromMap(json.decode(source));
}
